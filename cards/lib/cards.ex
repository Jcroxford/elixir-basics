defmodule Cards do
  @moduledoc """
    Provides methods for creating and hanlding a deck of cards 
  """

  def create_deck do
    ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K" ]
    suits = ["Spades", "Diamonds", "Hearts", "Clubs"]

    for rank <- ranks, suit <- suits do
      "#{rank} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end
  
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck. `hand_size` argument indicates how many cards
    should be in the hand.

  ## Examples

    iex> deck = Cards.create_deck
    iex> {hand, deck} = Cards.deal(deck, 1)
    iex> hand
    ["A of Spades"]

    iex> deck = Cards.create_deck
    iex> {hand, deck} = Cards.deal(deck, 2)
    iex> hand
    ["A of Spades", "A of Diamonds"]

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
        { :ok, binary } -> :erlang.binary_to_term(binary)
        { :error, _reason } -> "File does not exist"
     end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
