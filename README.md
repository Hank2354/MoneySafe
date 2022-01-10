![Header](https://i.imgur.com/7OB18H1.png)

# :money_with_wings: MoneySafe :money_with_wings:
Application for tracking income and expenses and analyzing expenses

- [About project](#About-project)
    - [Main block](#Main-block)
    - [Analytics block](#Analytics-block-:bar_chart:)
    - [All transactions block](#All-transactions-block)
    - [Settings block](#Settings-block)
- [Project Structure](#Project-Structure)
- [Getting started](#Getting-started)
- [Presentation](#Presentation)

## About project :warning:

This pet-project aims to help control expenses by setting the necessary budgets for categories.

In order to achieve maximum efficiency, it is necessary that the process of entering transactions into the application becomes a habit.

Minimalistic style, and intuitive interface help you quickly get used to and make all transactions in the application in a short time

### Main block
 
There are two buttons on the main screen for quickly adding income or expense. The user will perform these operations frequently, so the buttons are hard to miss.

Also, from this screen we can go to one of the main modules
- Analytics
- All transactions
- Settings

### Analytics block :bar_chart:

On this screen, we can see a brief summary of our transactions, see how our income or expenses are distributed, and you can also see how much we spent from the total planned budget for the month.

Charts and progress bar were used to display statistics

source: [Charts :bulb:](https://github.com/danielgindi/Charts)

### All transactions block :clipboard:

This screen displays all our transactions, the color separation will help to intuitively distinguish income from expenses, all data is sorted and displayed as follows:
1. Today transactions
2. Yesterday transactions
3. In month transactions
4. Other transactions

After tap on selected transaction will present detail VC, where user can delete transaction or change some information

### Settings block :construction:

In this block, the user can change his wallets or create new ones, also here you can change the selected categories of income and expenses, and set new budgets

## Project Structure :bookmark_tabs:

![Structure](https://i.imgur.com/SB3DQky.png)

## Built With 🛠

- Swift language
- Foundation
- UIKit
- CoreData
- VIPER Architecture
- Auto Layout
- GCD
- CocoaPods
- Only programmaticaly (without storyBoard)
- Navigation and routing without segue
- Charts
- MultiProgressView

## Getting started :rocket:

The project does not require additional settings to run :heavy_check_mark:

## Presentation :iphone:

Presentation video -> [On YouTube :tv:](https://www.youtube.com/watch?v=wpiecCm66Bw)

Screenshots:

| ![](https://i.imgur.com/MNsQY4j.png) | ![](https://i.imgur.com/dvAWhs6.png) | ![](https://i.imgur.com/JpuwS1q.png) | ![](https://i.imgur.com/yhH9rl7.png) | 
|----:|:----:|:----:|:----|
