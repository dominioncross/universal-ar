class UniversalAr::ReferenceNumber < ApplicationRecord
  self.table_name = 'reference_numbers'
  include UniversalAr::Concerns::Scoped
  include UniversalAr::Concerns::Polymorphic # the model this number belongs to

  def self.generate(scope, subject)
    # find the last number for this scope and subject type
    last_number = UniversalAr::ReferenceNumber.where(scope: scope, subject_type: subject.class)
                                              .order(number: :desc).first
    last_number = last_number.nil? ? 0 : last_number.number
    new_number = last_number + 1

    UniversalAr::ReferenceNumber.create scope: scope,
                                        subject_id: subject.id,
                                        subject_type: subject.class,
                                        number: new_number
  end
end
