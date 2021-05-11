# SPA Scaffold

This is a [Flutter](https://flutter.dev/) package to create a custom scaffold (without the official
Scaffold widget) for Single Page Applications. It was originally designed with ERP Applications in
mind.

A running web version can be found [here](https://flutter-spa-scaffold.firebaseapp.com/#/).

Please, visit the [example](https://github.com/Jmsil/flutter_spa_scaffold/tree/main/example)
project to see how the package can be used to implement an application.


# Features

## State Management

- StatefullWidget for ephemeral state management;
- [Provider](https://pub.dev/packages/provider) for app state management.


## Structure

The layout is divided into three main parts:

- The app bar on top;
- The stage area where the current page's content is shown;
- The main menu, which uses the slidable drawer design.


## Responsiveness

The interface is very responsive on all screen sizes. There is a limit of around 200px for width
and 280px for height when the interface begins not to respond very well (I think no one has a so
small screen nowadays :) ). Tip: you can use the browser Inspector tool with the device simulation
feature enabled to test the app behavior.

The app bar always try to show content as much as possible, like all the action buttons, the
application's name/title, and the open pages tab control.

If there is not enough space, the application's name/title space is used to gives open pages tab
control more space.

If the open pages tab control becomes very small, it is removed, the current page's name/title is
shown, and the app bar adds an action button to open the open pages list in the main menu.

Pages that contain a sidebar menu hide it under 1024px width. The hidden menu becomes available
through a slidable drawer on the right side of the screen. An action button is added to the app
bar every time the current page has a hidden menu.

There is always a Close button on the right side of the app bar to close the current page (the
homepage cannot be closed).


## Navigation

- Use the Menu button on the left side of the app bar or slide the cursor/finger from left to right
on the screen to open the main menu;

- Menu items that contain an arrow on the right have more items. Menu items with no arrow open
pages;

- Use the Back button in the main menu to back to the previous menu. Use the Home button to jump
directly to the root menu;

- Use the Open Pages button to open the open pages list (disabled if there are no open pages);

- Click on the logged user avatar to open the User Preferences page;

- Use the tab control in the app bar to navigate through the open pages or the Open Pages button
as a shortcut to open the main menu with the open pages list in focus;

- Use the Overflow button in the app bar when available to access the relevant menu of the current
page;

- Use the Close button in the app bar to close the current page (the homepage cannot be closed).