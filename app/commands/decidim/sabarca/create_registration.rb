# frozen_string_literal: true

module Decidim
  module Sabarca
    # This command extends Decidim::CreateRegistration
    # (decidim-core/app/commands/decidim/create_registration.rb)
    # adding Sabraca's custom attributes to `user_group`
    class CreateRegistration < Decidim::CreateRegistration
      private

      def create_user_group
        Decidim::UserGroupMembership.create!(
          user: @user,
          user_group: Decidim::UserGroup.new(
            name: form.user_group_name,
            document_number: form.user_group_document_number,
            phone: form.user_group_phone,
            decidim_organization_id: form.current_organization.id,
            scope_id: form.user_group_scope_id,
            url: form.user_group_url,
            address: form.user_group_address)
          )
      end
    end
  end
end
