class WalletSummaryController < ApplicationController

  def show
    @wallet_summary = get_wallets_summary()
    @summary = get_wallet_summary(1, Time.now)
  end

  def detail
    @p_targetDate = Time.now
    if (params[:targetDate].present?)
      @p_targetDate = params[:targetDate].to_date
    end

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

  def get_wallet_summary(walletId, targetDate)
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
      .where(wallet_id: walletId)
      .where(created_at: targetDate.all_month)
      .order('created_at desc')
    return summary
  end

end
