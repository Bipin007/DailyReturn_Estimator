This Application accepts ticker input from the user and print its stock price on the screen. By default Date range is of 10 days, however user can review the historical stock price upto 1 year.
I used Shiny package so that it can be user friendly application and thus even a laymen can find it easy to use.
It was implemented with the help of Reactive component of Shiny package to avoid blocking of user (otherwise will consider us "bot"). It also helps in fast processing because everytime getsymbols function does not execute(until and unless there is change in Date Range Input) and thus previous data can be fetched from cache memory.
Features:
Side Bar: Accept inputs for Ticker(DropDown and DateRangeInput UI)
Main Panel: Contains various tabs in order to view the daily returns for the selected Stock.
            Contains DownLoad button in order to download the stock ticker for the period of one Year.
            Conatins Tab named "Plot"- It plots the daily return for all 3 stocks and thus helps in analyses.
