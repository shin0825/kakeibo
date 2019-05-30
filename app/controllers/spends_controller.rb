class SpendsController < ApplicationController
  def index
    @spends= Spend.joins(:user).select('users.id AS user_id', 'users.name AS user_name', 'SUM(amount) AS amount').group('users.id','users.name').order('amount desc')
  end
end
