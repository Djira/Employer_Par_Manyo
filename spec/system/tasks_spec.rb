require 'rails_helper'
RSpec.describe 'Fonction de gestion des étiquettes', type: :system do
  describe 'fonction d'enregistrement' do
    let!(:user) { FactoryBot.create(:user) }

    before do
      visit new_session_path
      fill_in "adresse électronique", with: user.email
      fill_in "mot de passe ", with: "password"
      click_button "connexion"
    end

    context 'Lorsque les étiquettes sont enregistrées' do
      it 'Les étiquettes enregistrées sont affichées.' do
        visit new_label_path
        fill_in "Nom.", with: "Étiquettes."
        click_button "S'inscrire."
        expect(page).to have_content "Étiquettes enregistrées."
        expect(page).to have_content "Page de la liste des étiquettes"
      end
    end
  end

  describe 'fonction d'affichage de liste' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:label_1) { FactoryBot.create(:label, name: "Étiquette 1.", user: user) }
    let!(:label_2) { FactoryBot.create(:label, name: "Étiquette 2", user: user) }

    before do
      visit new_session_path
      fill_in "adresse électronique", with: user.email
      fill_in "mot de passe ", with: "password"
      click_button "connexion"
    end

    context 'Si la transition se fait vers l'écran de synthèse' do
      it 'La liste des étiquettes enregistrées s'affiche.' do
        visit labels_path
        expect(page).to have_content "Étiquette 1."
        expect(page).to have_content "Étiquette 2"
      end
    end
  end
end