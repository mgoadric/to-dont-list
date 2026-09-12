# short-notes-list
An app for anyone who wants to quickly jot down ideas or things to remember temporarily.
This app contains a list of notes and a button to write down a new note. Tap on an existing note to edit it, or hold down on a note to delete it.
This app is primarily for keeping track of information briefly, such as taking quick notes during a meeting before copying more robust notes down later.
Each of the widgets (except for to_do_items.dart) represents a different dialog the app can create - two for entering text, and one to double-check if the user wants to delete something. main.dart is able to summon any of these dialogs as needed, while keeping track of the number of items in the list.
