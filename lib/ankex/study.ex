defmodule Ankex.Study do
  @moduledoc """
  The StudySession context.
  """

  import Ecto.Query, warn: false
  alias Ankex.Repo

  alias Ankex.Study.StudySession

  def create_session(attrs) do
    %StudySession{}
    |> StudySession.changeset(attrs)
    |> Repo.insert()
  end
end
