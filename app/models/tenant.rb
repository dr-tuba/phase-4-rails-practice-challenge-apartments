class Tenant < ApplicationRecord
    has_many :leases, dependent: :destroy
    has_many :tenants, through: :leases

    validates :name, presence: true
    validates :age, numericality: { greater_than_or_equal_to: 18}
end
