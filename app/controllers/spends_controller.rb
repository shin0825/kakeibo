class SpendsController < ApplicationController
  def show
    @p_targetDate = Time.now
    if (params[:targetDate].present?)
      @p_targetDate = params[:targetDate].to_date
    end
    @page_type = "spends"

    @summary = get_spend_summary(@p_targetDate)
  end

  def new
    @spend = Spend.new()
    @del_spend = find_spend_by_id
  end

  def create
    @spend = Spend.new(spend_params)
    if @spend.save
      flash[:success] = "spend created!" + @spend.id.to_s
      redirect_to new_spend_path(id: @spend.id)
    else
      render 'new'
    end
  end

  def destroy
    @del_spend = find_spend_by_id
    @del_spend.destroy
    flash[:success] = "さっきのは消しました"
    redirect_to new_spend_path
  end

  private
  def get_spend_summary(targetDate)
    summary =  Spend.joins(:spend_reason)
      .select(
        'spend_reasons.id AS reason_id',
        'spend_reasons.name AS reason_name',
        'SUM(spends.amount) AS amount',
        'date(spends.created_at) AS created_at'
      )
      .where('spend_reasons.id<>999')
      .where(created_at: targetDate.in_time_zone.all_month)
      .group('created_at', 'reason_id', 'reason_name')
      .order('spends.created_at desc')
      .group_by(&:created_at)
    return summary
  end

  def spend_params
    params.require(:spend).permit(:amount, :wallet_id, :spend_reason_id,
                                 :user_id)
  end

  def find_spend_by_id
    if !params[:id].blank?
      return Spend.find(params[:id])
    else
      return nil
    end
  end
end
