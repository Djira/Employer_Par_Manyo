require 'rails_helper'

RSpec.describe 'fonctions de gestion des utilisateurs', type: :system do
  describe 'fonction d enregistrement' do
    context 'Si un utilisateur est enregistré' do
      it 'Passage à l écran de la liste des tâches.' do
        visit new_user_path
        fill_in "Nom.", with: "user"
        fill_in "adresse électronique", with: "user@user.com"
        fill_in "mot de passe", with: "password"
        fill_in "Mot de passe (confirmation).", with: "password"
        click_button "S'inscrire."
        expect(page).to have_content "Compte enregistré."
        expect(page).to have_content "Page de la liste des tâches"
      end
    end

    context 'Si vous avez accédé à l écran Liste des tâches sans vous connecter' do
      it 'Vous êtes redirigé vers l écran de connexion et le message (Veuillez vous connecter) s affiche.' do
        visit tasks_path
        expect(page).to have_content "Se connecter."
        expect(page).to have_content "Page de connexion"
      end
    end
  end

  describe 'Fonction de connexion' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:another_user) { FactoryBot.create(:user) }

    context 'Lorsque l on est connecté en tant qu utilisateur enregistré.' do
      before do
        visit new_session_path
        fill_in "adresse électronique", with: user.email
        fill_in "mot de passe (ordinateur)", with: "password"
        click_button "connexion"
      end

      it 'Vous serez redirigé vers l écran de la liste des tâches et le message "Vous êtes connecté" s affichera.' do
        expect(page).to have_content "Connecté."
        expect(page).to have_content "Page de la liste des tâches"
      end

      it 'Accès à votre propre écran de détail.' do
        click_link "Détails du compte."
        expect(page).to have_content "Page des détails du compte"
        expect(page).to have_content user.name
      end

      it 'En accédant à l'écran de détails d'une autre personne, vous accédez à l écran de la liste des tâches.' do
        visit user_path(another_user)
        expect(page).to have_content "Il est le seul à y avoir accès."
        expect(page).to have_content "Page de la liste des tâches"
      end

      it 'Lors de la déconnexion, l utilisateur est ramené à l écran de connexion et le message "Vous vous êtes déconnecté" s affiche.' do
        click_link "déconnexion"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "Déconnecté."
        expect(page).to have_content "Page de connexion"
      end
    end
  end

  describe 'Fonctions de l administrateur' do
    let!(:admin_user) { FactoryBot.create(:admin_user) }
    let!(:user) { FactoryBot.create(:user) }

    context 'Lorsque l administrateur se connecte.' do
      before do
        visit new_session_path
        fill_in "adresse électronique", with: admin_user.email
        fill_in "mot de passe", with: "password"
        click_button "connexion"
      end

      it 'Accès à l écran de la liste d utilisateurs.' do
        click_link "Liste des utilisateurs"
        expect(page).to have_content "Page de la liste des utilisateurs"
      end

      it 'Peut enregistrer des administrateurs.' do
        visit new_admin_user_path
        fill_in "Nom", with: "user"
        fill_in "adresse electronique", with: "user@user.com"
        fill_in "mot de passe", with: "password"
        fill_in "mot de passe (confirmation)", with: "password"
        click_button "S'inscrire."
        expect(page).to have_content "L'utilisateur a été enregistré."
        expect(page).to have_content "Page de la liste des utilisateurs"
      end

      it 'Accès à l écran des détails de l utilisateur.' do
        visit admin_user_path(user)
        expect(page).to have_content "Page des détails de l utilisateur"
        expect(page).to have_content user.name
      end

      it 'Vous pouvez modifier d autres utilisateurs que vous-même à partir de l écran de modification de l utilisateur.' do
        visit edit_admin_user_path(user)
        expect(page).to have_content "ユーザ編集ページ"
      end

      it 'ユーザを削除できる' do
        visit admin_users_path
        find("a[data-destroy_user='#{user.id}']").click
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'Utilisateur supprimé.'
        expect(page).to have_content "Page de la liste des utilisateurs"
      end
    end

    context 'Lorsqu un utilisateur général accède à l écran de la liste des utilisateurs' do
      before do
        visit new_session_path
        fill_in "adresse électronique", with: user.email
        fill_in "mot de passe", with: "password"
        click_button "s'inscrire"
      end

      it 'Passage à l écran de la liste des tâches avec le message d erreur "Seuls les administrateurs ont accès".' do
        visit admin_users_path
        expect(page).to have_content 'Seuls les administrateurs y ont accès.'
        expect(page).to have_content "Page de la liste des tâches"
      end
    end
  end
end