# Backend coding exercise

For this coding exercise you will use the public API provided by https://magicthegathering.io to build a command line tool that can query and filter Magic The Gathering cards.

## The exercise

Using **only** the https://api.magicthegathering.io/v1/cards endpoint and **without using any query parameters for filtering**, create a command-line tool that:

* Returns a list of **Cards** grouped by **`set`**.
* Returns a list of **Cards** grouped by **`set`** and within each **`set`** grouped by **`rarity`**.
* Returns a list of cards from the  **Khans of Tarkir (KTK)** set that ONLY have the colours `red` **AND** `blue`

## Environment

* You can use any one of the following programming languages: Ruby, Elixir, JavaScript, Crystal, Python, Go.

## Limitations

* You are **not** allowed to use a third-party library that wraps the MTG API.
* You can only use the https://api.magicthegathering.io/v1/cards endpoint for fetching all the cards. You **can't use query parameters** to filter the cards.

## What we look for

* Organise your code with low coupling and high cohesion.
* Avoid unnecessary abstractions. Make it readable, not vague.
* Name things well. We know _naming things_ is one of the two hardest problems in programming, so try to not make your solution too cryptic or too clever.
* Adhere to your language/framework conventions. No need to get _too_ creative.
* Take a pragmatic approach to testing. Just make sure the basics are covered.
* Take your time. We set no time limit, so simply let us know roughly how much time you spent. By our estimate, it should take roughly 4 hours.

## Bonus points for...

* Adding a section to this README explaining how you approached the problem: initial analysis, technical choices, trade-offs, etc.
* Using only the programming language's standard library.
* **Parallelising** the retrieval of all the **Cards** to speed up things.
* Respecting the API's Rate Limiting facilities.
