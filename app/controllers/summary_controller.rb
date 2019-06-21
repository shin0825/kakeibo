class SummaryController < ApplicationController
  def show
    @p_targetDate = Time.zone.now
    if (params[:targetDate].present?)
      @p_targetDate = params[:targetDate].to_date
    end
    @spend_summaries = get_spend_summary_by_reason(@p_targetDate)
    @income_summaries = get_income_summary_by_reason(@p_targetDate)

    spends_chart = @spend_summaries.to_a.pluck(:name, :s_amount)
    @spend_labels = spends_chart.map(&:first)
    @spend_datas = spends_chart.map(&:second)

    incomes_chart = @income_summaries.to_a.pluck(:reason_name, :amount)
    @income_labels = incomes_chart.map(&:first)
    @income_datas = incomes_chart.map(&:second)

    @spend_total_amount = get_spend_total_amount(@p_targetDate)
    @spend_budget_total_amount = get_spend_budget_total_amount(@p_targetDate)
    @income_total_amount = get_income_total_amount(@p_targetDate)
  end

  private
  def get_spend_budget_total_amount(targetDate)
    budgets_summary = SpendBudget
      .search_target_date_between(targetDate.in_time_zone.all_month.first, targetDate.in_time_zone.all_month.last)
      .select('SUM(COALESCE(amount, 0)) AS b_amount')
      .select('MAX(target_date) AS darget_date')

    amount = 0
    if budgets_summary.length > 0
      amount = budgets_summary.first.b_amount
    end

    return amount
  end

  def get_spend_summary_by_reason(targetDate)
      budgets_summary = SpendBudget
        .search_target_date_between(targetDate.in_time_zone.all_month.first, targetDate.in_time_zone.all_month.last)
        .group(:spend_reason_id)
        .select('spend_reason_id AS id, SUM(amount) AS b_amount')

      spends_summary = Spend
        .search_created_at_between(targetDate.in_time_zone.all_month.first, targetDate.in_time_zone.all_month.last)
        .group(:spend_reason_id)
        .select('spend_reason_id AS id, SUM(amount) AS s_amount')

       return SpendReason.search_without_transfar()
        .joins("LEFT JOIN (#{budgets_summary.to_sql}) budgets ON spend_reasons.id = budgets.id")
        .joins("LEFT JOIN (#{spends_summary.to_sql}) spends ON spend_reasons.id = spends.id")
        .select('name AS name')
        .select('COALESCE(b_amount, 0) - COALESCE(s_amount, 0) AS b_amount')
        .select('COALESCE(s_amount, 0) AS s_amount')
        .order('COALESCE(s_amount, 0) DESC')
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
