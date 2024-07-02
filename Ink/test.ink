//Prompt variables
VAR prompt_variable_name = ""
VAR prompt = ""

//Battle variables
VAR enemy_stats_key = ""
VAR won_battle = false
VAR lethal = false

//Player name/gender variables
VAR player_name = ""
VAR player_surname = ""
VAR he_she_they = ""
VAR he_is_she_is_they_are = ""
VAR he_was_she_was_they_were = ""
VAR him_her_them = ""
VAR his_her_their = ""
VAR boy_girl_child = ""

// Ink capitalisation code (v2) created by IFcoltransG
// Released into public domain
// May be used under the MIT No Attribution License

/*
    This is a sentinel token. It should be set to something that won't appear in any words.
*/
CONST START = "^^"

/*
    All letters supported by this tool.
    Lowercase and uppercase should match and have same order as each other.
    Lowercase should have (brackets) around.
    Punctuation should have an entry in get_string().
*/
LIST letters = /*
    lowercase:
    */ (a), (b), (c), (d), (e), (f), (g), (h), (i), (j), (k), (l), (m), (n), (o), (p), (q), (r), (s), (t), (u), (v), (w), (x), (y), (z), (á), /*
    uppercase:
    */ A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z, Á, /*
    punctuation:
    */ Space, Comma, FullStop

"Ah, hello! Come in, come in. It's so good to finally have a human behavior consultant for this storygame! I really want to make sure the human characters come across as believable, you know?" The centimanus author before you unfurls their three-meter long mottled body and hops off of the concave pedestal they were nestled on. "Care for some teleyo cider before we get started?"

*	["Am I the only consultant?"]
	For later
*	["Sure!"]
	The Centimanus pours some dark yellow cider into a vessel that straddles the line between cup and bowl, passes it hand-to-hand down the length of their body, and finally offers it to you while the other end of their body is pouring some for themselves.
*	["I really shouldn't."]
	The Centimanus bobs its upper half for a second before pouring some for themselves.
*	["I really shouldn't." (Gesture to hand over a glass anyways)]
	You're skilled enough at charades that even an alien can understand what you're trying to communicate!

- "Anyways," continues the centimanus, "this story begins with a human born on the Terran Empire border colony of Temi. They were born into a family with the surname..."
~ prompt = "Enter surname"
~ prompt_variable_name = "player_surname"
@
As is tradition in much of the greater Local Group, this child's parents bestowed upon them a name. This tradition serves the important function of teaching children from an early age that, in life, core parts of their self will often be determined by circumstances beyond their control. Sure, one can change their name later, but the message is sent loud and clear. This child's name was to be...
~ prompt = "Enter name"
~ prompt_variable_name = "player_name"
@
And with what gender does {player_name} {player_surname} identify? Don't worry, you can always change this later, just like in real life. Never let anyone tell you Sirrus's storygames aren't realistic.
*	["Male"]
	~ he_she_they = "he"
	~ he_is_she_is_they_are = "he is"
	~ he_was_she_was_they_were = "he was"
	~ him_her_them = "him"
	~ his_her_their = "his"
	~ boy_girl_child = "boy"
*	["Female"]
	~ he_she_they = "she"
	~ he_is_she_is_they_are = "she is"
	~ he_was_she_was_they_were = "she was"
	~ him_her_them = "her"
	~ his_her_their = "her"
	~ boy_girl_child = "girl"
*	["Nonbinary"]
	~ he_she_they = "they"
	~ he_is_she_is_they_are = "they are"
	~ he_was_she_was_they_were = "they were"
	~ him_her_them = "them"
	~ his_her_their = "their"
	~ boy_girl_child = "child"

- {player_name}'s mother was a decorated soldier of the Terran Mandate. She had the bravery and sense of humor necessary to withstand a career where one works in the office one week, is putting down riots the next, and finds themselves in a dropship hurtling towards an enemy-controlled planet the week after that. Years of service and doing what she had to do to survive had slowly but surely eroded away her sense of purpose and replaced it with mere duty.
{player_name}'s mother passed onto the young {player_name} her...
*	[diligence]
*	[sense of duty]
*	[stoicism]

- Ultimately, she found something worth fighting for in {player_name}'s father, a soft-spoken man with unflinching convictions. They met during negotiations over a rebellion at Aranti, where he was a member of one of the few rebel-aligned groups willing to negotiate with the government and unwilling to break the law. Once the crisis at Aranti was settled and reforms were promised, he became a beloved icon on the planet, and he successfully leveraged this into a political career as an internal reformist.
{player_name}'s father passed onto the young {player_name} his most cherished value of...
*	[tolerance]
*	[liberty]
*	[justice]

- ~ enemy_stats_key = "two_pirates"
$space

{won_battle:
        -> beat_pirates
- else:
        -> lost_to_pirates
}

=== beat_pirates ===
You beat the pirates!
    -> END

=== lost_to_pirates ===
You lost to the pirates!
    -> END

/*
    Capitalises the first letter of a word made of supported symbols.
    Will cut off any word at the first unsupported symbol.
    e.g. capitalise_start("hello") == "Hello"
    e.g. capitalise_start("HELLO") == "HELLO"
*/
=== function capitalise_start(word) ===
    {word == "":
        ~ return ""
    }
    ~ temp start = first_letter_after(word, "", LIST_ALL(letters))
    ~ return "{capitalise_letter(start)}" + rest_of_letters(word, get_string(start))

/*
    Capitalises a word made of supported symbols.
    Will cut off any word at the first unsupported symbol.
    e.g. capitalise_whole("hello") == "HELLO"
    e.g. capitalise_whole("HELLO") == "HELLO"
*/
=== function capitalise_whole(word) ===
    {word == "":
        ~ return ""
    }
    ~ temp start = first_letter_after(word, "", LIST_ALL(letters))
    ~ temp rest = rest_of_letters(word, get_string(start))
    ~ return "{capitalise_letter(start)}" + capitalise_whole(rest)


// OTHER FUNCTIONS BELOW

/*
    Returns the string version of a letter.
    Has special cases for punctuation — otherwise just returns the name.
    e.g. get_string(A) == "A"
    e.g. get_string(FullStop) == "."
*/
=== function get_string(letter)
    {letter:
        - Space:
            ~ return " "
        - Comma:
            ~ return ","
        - FullStop:
            ~ return "."
        - else:
            ~ return "{letter}"
    }

/*
    Gets the rest of the symbols after a certain start (supported symbols only).
    e.g. rest_of_letters("hello", "he") == "llo"
*/
=== function rest_of_letters(word, start) ===
    {word == start:
        ~ return ""
    }
    ~ temp next_letter = get_string(first_letter_after(word, start, LIST_ALL(letters)))
    {next_letter == "":
            ~ return ""
        - else:
            ~ return next_letter + rest_of_letters(word, start + next_letter)
    }

/*
    Takes a list element from `letters` and capitalises it.
    e.g. capitalise_letter(a) == A
    e.g. capitalise_letter(A) == A
*/
=== function capitalise_letter(letter) ===
    {letters ? letter:
            ~ return letter + LIST_COUNT(letters)
        - else:
            ~ return letter
    }

/*
    Gets the first symbol after a certain start (supported symbols only).
    `options` parameter is an internal detail and should be passed `LIST_ALL(letters)`
    e.g. first_letter_after("hello", "he", LIST_ALL(letters)) == "l"
*/
=== function first_letter_after(word, start, options) ===
    {options:
            ~ temp test_letter = pop(options)
            {starts_with(word, "{start}{get_string(test_letter)}"):
                ~ return test_letter
            }
            ~ return first_letter_after(word, start, options)
        - else:
            ~ return ()
    }

/*
    Checks if a certain string starts with another string.
    The `START` constant should be set to a value that does not appear within strings.
*/
=== function starts_with(word, start) ===
    ~ return START + word ? START + start

/*
	Takes the bottom element from a list, and returns it, modifying the list.
	Returns the empty list () if the source list is empty.
	Usage: 
	LIST fruitBowl = (apple), (banana), (melon)
	I eat the {pop(fruitBowl)}. Now the bowl contains {fruitBowl}.
*/
=== function pop(ref _list) 
    ~ temp el = LIST_MIN(_list) 
    ~ _list -= el
    ~ return el 