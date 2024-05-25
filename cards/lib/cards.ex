defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing the cards in the deck
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines if a deck contains a given card

  ## Examples
    iex> deck = Cards.create_deck
    iex> Cards.contains?(deck, "Ace of Spades")
    true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into 2 lists, a hand and the remainder of the deck.
    The `hand_size` is the number of cards that will be in the hand

  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, _} = Cards.deal(deck, 3)
      iex> hand
      ["Ace of Spades", "Two of Spades", "Three of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, :enoent} -> "File does not exist"
    end
  end

  # PIPE OPERATORS
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
