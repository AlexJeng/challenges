## Bitcoin Scaling Class

Create a general scale class to encapsulate this functionality.

Basic scaling logic:

The scaling function should convert all prices to GBP or XBT after scaling
appropriately. Should also allow for the reverse conversion.

It should take at least 4 arguments. The output currency (XBT or GBP), the
function that has been called or is calling the scaling class, whether the
field to be scaled is a price field or not and the amount to be scaled.

- All values supplied for Bitcoin (XBT) are input in units of 0.0001 XBT
- All values supplied for Pounds (GBP) are input in units of 0.01 GBP

For the following functions any price provided should be scaled by 10000

- PlaceOrder

For the following functions any prices returned are scaled by 10000

- GetOrders
- CancelOrder
- WatchOrders
- WatchTicker

Any other function does not use the price field.

Examples:

A) Supplied a PlaceOrder for quantity: 2000000, price: 1234560000 base: XBT,
counter: GBP

This is a buy limit order of quantity 200 Bitcoin at a unit price of £1234.56

B) Supplied a PlaceOrder for total: 1234567890, base: XBT, counter: GBP This is a
buy market order with an order total of £12345678.90

C) Supplied a CancelOrder returns quantity: 1000000, price: 1234560000 base: XBT,
counter: GBP

This is an order of quantity 100 Bitcoin at a unit price of £1234.56
