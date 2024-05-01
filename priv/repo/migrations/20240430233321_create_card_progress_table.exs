defmodule Ankex.Repo.Migrations.CreateCardProgressTable do
  use Ecto.Migration

  def change do
    create table(:card_progresses, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :study_session_id, references(:study_sessions, on_delete: :delete_all, type: :binary_id)
      add :card_id, references(:cards, on_delete: :delete_all, type: :binary_id)
      add :status, :string
      add :review_date, :naive_datetime
      add :next_interval, :integer

      timestamps()
    end
  end
end
