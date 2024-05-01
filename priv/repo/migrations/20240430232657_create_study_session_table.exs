defmodule Ankex.Repo.Migrations.CreateStudySessionTable do
  use Ecto.Migration

  def change do
    create table(:study_sessions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)
      add :deck_id, references(:decks, on_delete: :delete_all, type: :binary_id)
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime

      timestamps()
    end

    create index(:study_sessions, [:user_id])
    create index(:study_sessions, [:deck_id])
  end
end
