class IncomesController < ApplicationController
  def index
    @p_targetDate = Time.zone.now
    if (params[:year].present? && params[:month].present?)
      @p_targetDate = Time.zone.local(params[:year], params[:month], 1, 0, 0, 0)
    end
    @page_type = "incomes"
    @summary = get_income_summary(@p_targetDate)
  end

  def new
    @income = Income.new()
    @del_income = find_income_by_id
  end

  def create
    @income = Income.new(income_params)
    if @income.save
      flash[:success] = "income created!" + @income.id.to_s
      redirect_to new_income_path(id: @income.id)
    else
      render 'new'
    end
  end

  def destroy
    @del_income = find_income_by_id
    @del_income.destroy
    flash[:success] = "さっきのは消しました"
    redirect_back(fallback_location: root_path)
  end

  private
  def get_income_summary(targetDate)
    summary =  Income.search_without_transfar.joins(:income_reason)
      .select(
        'incomes.id',
        'income_reasons.id AS reason_id',
        'income_reasons.name AS reason_name',
        'incomes.amount',
        'incomes.created_at AS created_at',
        'date(incomes.created_at) AS created_dt'
      )
      .where(created_at: targetDate.in_time_zone.all_month)
      .order('incomes.created_at desc')
    return summary
  end

  def income_params
    params.require(:income).permit(:amount, :wallet_id, :income_reason_id,
                                 :user_id)
  end

  def find_income_by_id
    if !params[:id].blank?
      return Income.find_by(id: params[:id])
    else
      return nil
    end
  end
end
