class IncomesController < ApplicationController
  def show
    @p_targetDate = Time.now
    if (params[:targetDate].present?)
      @p_targetDate = params[:targetDate].to_date
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
      flash[:danger] = "なんかダメでした"
      redirect_to new_income_path()
    end
  end

  def destroy
    @del_income = find_income_by_id
    @del_income.destroy
    flash[:success] = "さっきのは消しました"
    redirect_to new_income_path
  end


  private
  def get_income_summary(targetDate)
    summary =  Income.joins(:income_reason)
      .select(
        'income_reasons.id AS reason_id',
        'income_reasons.name AS reason_name',
        'SUM(incomes.amount) AS amount',
        'date(incomes.created_at) AS created_at'
      )
      .where('income_reasons.id<>999')
      .where(created_at: targetDate.all_month)
      .group('created_at', 'reason_id', 'reason_name')
      .order('incomes.created_at desc')
      .group_by(&:created_at)
    return summary
  end

  def income_params
    params.require(:income).permit(:amount, :wallet_id, :income_reason_id,
                                 :user_id)
  end

  def find_income_by_id
    if !params[:id].blank?
      return Income.find(params[:id])
    else
      return nil
    end
  end
end
