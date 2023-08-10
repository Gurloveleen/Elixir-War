defmodule War do
  @moduledoc """
    Documentation for `War`.
  """

  @doc """
    Function stub for game/1 is given below. Feel free to add
    as many additional helper functions as you want.

    The tests for the game function can be found in test/war_test.exs.
    You can add your five test cases to this file.

    Run the tester by executing 'mix test' from the war directory
    (the one containing mix.exs)
  """



  def deal(shuf) do
    p1=Enum.reverse(Enum.drop_every(shuf,2)) #Distributing cards to First Player(pile1)
    p2=Enum.reverse(Enum.take_every(shuf,2)) #Distributing cards to Second Player(pile2)
    p1u=Enum.map(p1, fn 1 -> 14; x -> x end)
    p2u=Enum.map(p2, fn 1 -> 14; x -> x end) # Changing 1 to 14
    game(p1u,p2u,[]) # pile1, pile2 and temporary pile which is empty at the starting
    end
    def game([],[],p3) do # Case where there is a tie
    t=Enum.sort(p3,:desc)
    Enum.map(t, fn 14 -> 1; x -> x end)
    end
    def game([],p2,p3) do # Case where player2 wins
      Enum.map(p2++ p3, fn 14 -> 1; x -> x end)
    end
    def game(p1,[],p3) do # Case where player1 wins
    Enum.map(p1++ p3, fn 14 -> 1; x -> x end)
    end
    def game([h1],[h2|t2],p3) do # Case where 1 element remains in Player 1 pile
      if h1>h2 do
        t=Enum.sort(p3++ [h1,h2],:desc)
        game([]++ t,t2,[])
        else
          t=Enum.sort(p3++ [h1,h2],:desc)
        game([],t2++ t,[])
        end
    end
    def game([h1|t1],[h2],p3) do  # Case where 1 element remains in Player 2 pile
      if h2>h1 do
        t=Enum.sort(p3++ [h1,h2],:desc)
        game(t1,[]++ t,[])
        else
        t=Enum.sort(p3++ [h1,h2],:desc) #Sorting the Temporary pile in descending order
        game(t1++ t,[],[])
        end
  end
    def game([h1|t1],[h2|t2],p3) do # Main game
    if h1>h2 do
    t=Enum.sort(p3++ [h1,h2],:desc)
    game(t1++ t,t2,[]) # Adding the cards at the end of player 1 deck and calling the game function the remaining cards and also emptying the temporary list
    else if h2>h1 do
    t=Enum.sort(p3++ [h1,h2],:desc)
    game(t1,t2++ t,[]) # Adding the cards at the end of player 2 deck and calling the game function the remaining cards and also emptying the temporary list
    else if length([h1|t1])>=2 && length([h2|t2]) >=2 do
    game(tl(t1),tl(t2), Enum.sort(p3++ [h1,h2,hd(t1),hd(t2)],:desc)) # Adding the Face up and Face down cards in temporary pile and calling the game function with 3rd card for both piles in case of War
    end
  end
  end
  end
end
