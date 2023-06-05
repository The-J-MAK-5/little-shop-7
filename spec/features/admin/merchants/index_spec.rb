require "rails_helper"

RSpec.describe "/admin/merchants, admin::merchants index page" do
  let!(:merchant_1) { create(:merchant) }
  let!(:merchant_2) { create(:merchant, status: 1) }

  describe "as an admin on the admin::merchants index page" do
    it "I see the name of each merchant and their links - US24" do
      visit admin_merchants_path

      within ".merchant-#{merchant_1.id}" do
        expect(page).to have_link(merchant_1.name)
      end

    within ".merchant-#{merchant_2.id}" do
      expect(page).to have_link(merchant_2.name)
    end
  end

    it "shows a button to enable/disable a merchant - US27" do
      visit admin_merchants_path

      within ".merchant-#{merchant_1.id}" do
        expect(merchant_1.status).to eq("enabled")
        expect(page).to have_button("Disable")
      end

      within ".merchant-#{merchant_2.id}" do
        expect(merchant_2.status).to eq("disabled")
        expect(page).to have_button("Enable")
      end
    end

    it "updates status of given merchant when clicked - US27" do
      visit admin_merchants_path

      within ".merchant-#{merchant_1.id}" do
        expect(merchant_1.status).to eq("enabled")
        expect(page).to have_button("Disable")
        expect(page).to_not have_button("Enable")
      
        click_button "Disable"

        expect(current_path).to eq(admin_merchants_path)
        expect(merchant_1.status).to eq("disabled")
        expect(page).to have_button("Enable")
      end

      within ".merchant-#{merchant_2.id}" do
        expect(merchant_1.status).to eq("disabled")
        expect(page).to have_button("Enable")
        expect(page).to_not have_button("Disable")

        click_button "Enable"

        expect(current_path).to eq(admin_merchants_path)
        expect(merchant_2.status).to eq("enabled")
        expect(page).to have_button("Disable")
    end
    end
  end
end
