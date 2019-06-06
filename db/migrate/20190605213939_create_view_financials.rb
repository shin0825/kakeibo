class CreateViewFinancials < ActiveRecord::Migration[5.1]
  DB_NAME = "view_financials"

  def up
    execute create_view_sql
  end

  def down
    execute drop_view_sql
  end

  def create_view_sql
    "
      create or replace view #{DB_NAME}
      as
        select
          user_id
          ,wallet_id
          ,spend_reasons.name AS reason_name
          ,amount*-1 AS amount
          ,spends.created_at AS created_at
        from
          spends
          inner join spend_reasons
            on spends.spend_reason_id = spend_reasons.id
        union
        select
          user_id
          ,wallet_id
          ,income_reasons.name AS reason_name
          ,amount
          ,incomes.created_at AS created_at
        from
          incomes
          inner join income_reasons
            on incomes.income_reason_id = income_reasons.id
      ;
    "
  end

  def drop_view_sql
    "DROP VIEW #{DB_NAME}"
  end

end
