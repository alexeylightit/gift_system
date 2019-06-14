# encoding : utf-8
Money.locale_backend = :i18n
MoneyRails.configure do |config|
  config.default_currency = :usd
  config.raise_error_on_money_parsing = false
end
