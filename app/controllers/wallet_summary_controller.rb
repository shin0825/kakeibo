class WalletSummaryController < ApplicationController

  def show
    @p_targetDate = Time.now
    @wallet_summary = get_wallets_summary()
  end

  def detail
    @p_targetDate = Time.now
    @p_targetDate = params[:targetDate].to_date if (params[:targetDate].present?)

    @p_walletName = '全て'
    @p_walletName = Wallet.find_by(id: params[:walletId]).name if (params[:walletId].present? && !params[:walletId].blank?)

    @p_walletId = params[:walletId] if (params[:walletId].present?)

    @summary = get_wallet_summary(@p_targetDate)
  end

  private
  def get_wallets_summary
    wallets_summary = Wallet.joins('LEFT OUTER JOIN view_financials ON id = wallet_id')
      .select('id', 'name', 'SUM(COALESCE(amount, 0)) AS amount')
      .group('id', 'name')
      .order('id')
    return wallets_summary
  end

  def get_wallet_summary(targetDate)
    summary =  ViewFinancial.joins(:wallet)
      .joins(:user)
      .select(
        'wallets.id AS wallet_id',
        'wallets.name AS wallet_name',
        'users.name AS user_name',
        'reason_name',
        'amount',
        'date(view_financials.created_at) AS created_at'
      )
      .where(created_at: targetDate.all_month)
      .order('created_at desc')
    summary = summary.where(wallet_id: params[:walletId]) if params[:walletId].present?
    return summary.group_by(&:created_at)
  end

end
