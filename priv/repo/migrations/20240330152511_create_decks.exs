defmodule Ankex.Repo.Migrations.CreateDecks do
  use Ecto.Migration

  def change do
    create table(:decks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :string
      add :public, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:decks, [:name, :user_id])
  end
end
