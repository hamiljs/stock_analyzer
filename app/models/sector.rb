class Sector < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  has_many :companies
  memoize :companies

  def self.median_formulae(*formulae)
    formulae.each { |formula|
      define_method(formula) {
        companies.collect(&formula).median
      }
    }
  end

  median_formulae :pe_ratio, :peg_ratio, :debt_ratio,:debt_to_equity_ratio, :price_to_book_value,
                  :ev_to_sales, :ev_to_ebitda, :roe, :roce, :operating_cash_to_sales


  def <=> other
    return 1 if self.debt_ratio.nil? or other.debt_ratio.nil?
    self.debt_ratio <=> other.debt_ratio
  end
end
