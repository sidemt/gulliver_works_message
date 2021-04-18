# frozen_string_literal: true
# 雇用形態
employment_statuses = [
  { name: '正社員' }, { name: '契約社員' }, { name: 'アルバイト' }, { name: '新卒' }, { name: '派遣社員' }
]

employment_statuses.each do |employment_status|
  EmploymentStatus.find_or_create_by(name: employment_status[:name])
end
