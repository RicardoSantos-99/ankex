# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ankex.Repo.insert!(%Ankex.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Ankex.Repo
deck_id = "c122c886-7625-4074-ab0f-c02e5ca2020c"

cards =
  [
    %Ankex.Decks.Card{
      front: "Pen",
      back: "Caneta",
      deck_id: deck_id
    },
    %Ankex.Decks.Card{
      front: "Book",
      back: "Livro",
      deck_id: deck_id
    },
    %Ankex.Decks.Card{
      front: "Table",
      back: "Mesa",
      deck_id: deck_id
    },
    %Ankex.Decks.Card{
      front: "Chair",
      back: "Cadeira",
      deck_id: deck_id
    },
    %Ankex.Decks.Card{
      front: "Computer",
      back: "Computador",
      deck_id: deck_id
    },
    %Ankex.Decks.Card{
      front: "Mouse",
      back: "Rato",
      deck_id: deck_id
    },
    %Ankex.Decks.Card{
      front: "Keyboard",
      back: "Teclado",
      deck_id: deck_id
    },
    %Ankex.Decks.Card{
      front: "Finger",
      back: "Dedo",
      deck_id: deck_id
    },
    %Ankex.Decks.Card{
      front: "Hand",
      back: "Mão",
      deck_id: deck_id
    },
    %Ankex.Decks.Card{
      front: "Foot",
      back: "Pé",
      deck_id: deck_id
    },
    %Ankex.Decks.Card{
      front: "Leg",
      back: "Perna",
      deck_id: deck_id
    },
    %Ankex.Decks.Card{
      front: "Arm",
      back: "Braço",
      deck_id: deck_id
    },
    %Ankex.Decks.Card{
      front: "Head",
      back: "Cabeça",
      deck_id: deck_id
    }
  ]
  |> Enum.map(&Repo.insert!(&1))
