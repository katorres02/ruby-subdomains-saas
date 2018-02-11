class Tenant < ApplicationRecord
  RESTRICTED_SUBDOMAINS = %w(www)

  validates :name, presence: true,
                  uniqueness: { case_sensitive: false },
                  format: { with: /\A[\w\-]+\Z/i, message: 'contains invalid characters' },
                  exclusion: { in: RESTRICTED_SUBDOMAINS, message: 'restricted' }

  before_validation :downcase_subdomain
  after_create      :create_subdomain

  private
  
  def downcase_subdomain
    self.name = name.try(:downcase)
  end

  def create_subdomain
    begin
      Apartment::Tenant.create(name)
    rescue
      p "Error creating subdomain"
    end
  end
end
