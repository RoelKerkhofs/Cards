defmodule Cards do

  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

    @doc """
      Returns a list of strings representing a deck of playing cards
    """
    def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Hearts", "Clubs", "Diamonds"]

    for value <- values, suit <- suits do
        "#{value} of #{suit}"
    end

    end

  @doc """
    Returns a shuffeled deck based on a `deck`
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    answers whether a `card` is in a `deck`

    ## Examples
        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Ace of Spades")
        true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

@doc """
  Divides a deck into a hand and the remainder of the deck.
  the `hand_size` argument indicates how many cards should be
  in the hand

  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck,1)
      iex> hand
      ["Ace of Spades"]
"""
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Saves a `deck` to disk under speficied `filename`
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Reads a `deck` to disk under speficied `filename`
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "File does not exist"
    end
  end

  @doc """
    Shorthand for creating a deck, shuffling it and deal
    with a specified `hand_size`
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
