class Settings < Setttingslogic
  source "#{Rails.root}/config/bsmi_config.yml"
  namespace Rails.env
end
