class SummaryController < ApplicationController
  def show
    @p_targetDate = Time.now
    if (params[:targetDate].present?)
      @p_targetDate = params[:targetDate].to_date
    end
    @spend_summarys = get_spend_summary_by_reason(@p_targetDate)
    @income_summarys = get_income_summary_by_reason(@p_targetDate)

    spends_chart = @spend_summarys.to_a.pluck(:reason_name, :amount)
    @spend_labels = spends_chart.map(&:first)
    @spend_datas = spends_chart.map(&:second)

    incomes_chart = @income_summarys.to_a.pluck(:reason_name, :amount)
    @income_labels = incomes_chart.map(&:first)
    @income_datas = incomes_chart.map(&:second)

    @spend_total_amount = get_spend_total_amount(@p_targetDate)
    @income_total_amount = get_income_total_amount(@p_targetDate)
  end

  private
  def get_spend_summary_by_reason(targetDate)

    summary = SpendReason.search_without_transfar()
      .left_outer_joins(:spend)
      .left_outer_joins(:spend_budget)
      .select(
        'spend_reasons.id AS reason_id',
        'spend_reasons.name AS reason_name',
        'SUM(spends.amount) AS amount',
        'DATE(MAX(spends.created_at)) AS created_at',
        'SUM(spend_budgets.amount) AS b_amount',
        'DATE(MAX(spend_budgets.target_date)) AS target_date'
      )
      .where(spend_budgets: { target_date: targetDate.in_time_zone.all_month } )
      .where(spends: { created_at: targetDate.in_time_zone.all_month } )
      .group('spend_reasons.id', 'spend_reasons.name')
      .order('spend_reasons.id')

    return summary
  end

  def get_spend_total_amount(targetDate)
    summary = Spend.search_without_transfar.joins(:spend_reason)
      .select(
        'SUM(spends.amount) AS amount',
        'MAX(spends.created_at) AS created_at'
      )
      .where(created_at: targetDate.in_time_zone.all_month)

    amount = 0
    if summary.length > 0
      amount = summary.first.amount
    end

    return amount
  end

  def get_income_summary_by_reason(targetDate)
    summary = Income.search_without_transfar.joins(:income_reason)
      .select(
        'income_reasons.id AS reason_id',
        'income_reasons.name AS reason_name',
        'SUM(incomes.amount) AS amount',
        'MAX(incomes.created_at) AS created_at'
      )
      .where(created_at: targetDate.in_time_zone.all_month)
      .group('income_reasons.id', 'income_reasons.name')
      .order('income_reasons.id')
    return summary
  end

  def get_income_total_amount(targetDate)
    summary = Income.search_without_transfar.select(
        'SUM(amount) AS amount',
        'MAX(created_at) AS created_at'
      )
      .where(created_at: targetDate.in_time_zone.all_month)

    amount = 0
    if summary.length > 0
      amount = summary.first.amount
    end

    return amount
  end
end
