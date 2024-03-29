require 'rails_helper'

 RSpec.describe 'Fonction du modèle d'étiquetage', type: :model do

  let!(:user) { FactoryBot.create(:user) }

   describe 'Tests de validation.' do
     context 'Si le nom de l'étiquette est une lettre vide' do
       it 'La validation échoue.' do
        label = Label.create(
          name: "",
          user_id: user.id,
        )
        expect(label).not_to be_valid
      end
     end

     context 'Si le nom de l'étiquette a une valeur' do
       it 'Validation réussie' do
        label = Label.create(
          name: "Étiquettes.",
          user_id: user.id,
        )
        expect(label).to be_valid
       end
     end
   end
 end