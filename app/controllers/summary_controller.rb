class SummaryController < ApplicationController
  def show
    @p_targetDate = Time.now
    if (params[:targetDate].present?)
      @p_targetDate = params[:targetDate].to_date
    end
    @spend_summarys = get_spend_summary(@p_targetDate)
    @income_summarys = get_income_summary(@p_targetDate)

    spends_chart = @spend_summarys.to_a.pluck(:reason_name, :amount)
    @spend_labels = spends_chart.map(&:first)
    @spend_datas = spends_chart.map(&:second)

    incomes_chart = @income_summarys.to_a.pluck(:reason_name, :amount)
    @income_labels = incomes_chart.map(&:first)
    @income_datas = incomes_chart.map(&:second)
  end

  private
  def get_spend_summary(targetDate)
    summary = Spend.joins(:spend_reason)
      .select(
        'spend_reasons.id AS reason_id',
        'spend_reasons.name AS reason_name',
        'SUM(spends.amount) AS amount',
        'MAX(spends.created_at) AS created_at'
      )
      .where(created_at: targetDate.all_month)
      .group('reason_id', 'reason_name')
      .order('reason_id')
    return summary
  end

  def get_income_summary(targetDate)
    summary = Income.joins(:income_reason)
      .select(
        'income_reasons.id AS reason_id',
        'income_reasons.name AS reason_name',
        'SUM(incomes.amount) AS amount',
        'MAX(incomes.created_at) AS created_at'
      )
      .where(created_at: targetDate.all_month)
      .group('reason_id', 'reason_name')
      .order('reason_id')
    return summary
  end
end
