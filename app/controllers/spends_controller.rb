class SpendsController < ApplicationController
  def index
    @p_targetDate = Time.zone.now
    if (params[:year].present? && params[:month].present?)
      @p_targetDate = Time.zone.local(params[:year], params[:month], 1, 0, 0, 0)
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
    redirect_back(fallback_location: root_path)
  end

  private
  def get_spend_summary(targetDate)
    summary =  Spend.search_without_transfar.joins(:spend_reason)
      .select(
        'spends.id',
        'spend_reasons.id AS reason_id',
        'spend_reasons.name AS reason_name',
        'spends.amount',
        'spends.created_at AS created_at',
        'date(spends.created_at) AS created_dt'
      )
      .where(created_at: targetDate.in_time_zone.all_month)
      .order('spends.created_at desc')
    return summary
  end

  def spend_params
    params.require(:spend).permit(:amount, :wallet_id, :spend_reason_id,
                                 :user_id)
  end

  def find_spend_by_id
    if !params[:id].blank?
      f = Spend.find_by(id: params[:id])
    else
      return nil
    end
  end
end
