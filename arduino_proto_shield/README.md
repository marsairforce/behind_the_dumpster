# A shield for some useful things I always seem to like to use in my projects.

# Motivation
A lot of the things I build evolve to have the same sort of things added to them.

* A real time clock.
* A FRAM device for non volatile storage. EEPROMs are ok too. but I am anxious to use them because of their much smaller lifecycle in the order of 100K writes.
* A piezo buzzer.
* An ambient light sensor. - though this is perhaps not useful on a shield. we would want these to be positioned where we want to measure stuff.
* An IR receiver and Transmitter (simple remote control projects) - again, not convenient on a shield?
* A LCD
* A bunch of push buttons (a panel of buttons, and LEDs)

# Goals
* To add these things to an Arduino UNO, but not consume a bunch of IO pins. e.g. the classic LCD keypad shield requires like 8 pins. A lot of these things can be attached using the I2C bus.
* To have a bit of useful stuff that is generally useful for kids to work with when learning about how microcontrollers work. So having something you can just plug in and upload a sketch and then have it work.
* To be able to stack more shields on top of our shield.
* To have this work open and extensible in the true spirit of open source hardware.

# Challenges
* The form factor
* IO Pins
* Memory
* System processing power
* Power Considerations
* LCD shields need to be on top

## Form Factor
The usual Arduino shield form factor has a stupid-ass arrangement for pins. This means you can't just use a regular proto board with 0.1" center holes and make your own shield. That's it. I am going to design a custom printed circuit board shield out of anger and/or revenge.

![The dimensions for the UNO](doc/Arduino%20Uno%20board%20size.png)

The Internet is full of many many kinds of Arduino proto shields. Likey this is because everyone who used Arduino discovered right away "Hey, these pins are some kind of stupid-ass arrangement, so I can't just user a regular proto board with 0.1" center holes.. That's it. I am going to design a custom printed circuit board shield out of anger and/or revenge.

Only most people seem to choose to have their board for sale and there are not usually a CAD design model to work with.

And I haven't found a good one I actually like. Though the Adafruit proto shield v5 is pretty close.

So here we are.


## IO Pins
There are only so many pins on the device. So you can very quickly use them all up with only a few things. Anything we use on our proto shield should use as little pins as possible. Most stuff can just work off the I2C bus.

We should have a facility to conveniently change the I2C addresses for the things we have on the bus so more than one of that device type could be used.

# Memory
Sure we can staple a lot of hardware onto a shield and leave a lot of the IO pins free to use. But at the end of the day there is only so much room for program memory in the controller. Having to load the software support for all the things might not leave much room for the user applications. I guess if we are targeting educatioonal frontiers here then we would provide the sample sketches anyway.

# System processing power
I would like to entertain the idea of general purpose offloading of the details. Like have a small slave (AVR?) controller on the shield. And it looks like a single I2C device. So it provides virtual registers to access over I2C the many peripherals it is fronting for us. But then we end up writing all our own library to support these things too, so we are back to the memory constraint again.

Its also hard to think about doing anything complicated like this when we only have a single I2C port. Like other microcontroller families like the STM32 family come in variants that operate at hundreds of MHz clock frequency, have many more IO pins, but then also have more than one I2C and even serial port. So it is over all a much better ecosystem for complex things and then at what point do we want to not try to build stuff for the Arduino platform then.

## Power Considerations
Some devices require more power, like WIFI adapters. Or different voltages. Like motor drivers.

Some shields I have seen have hook ups for their separate power supply. Some have what looks like a barrel jack. So then do you give the power to the shield and it has a regulator for its things and then also feeds power back to the main Arduino board? Or do you end up needing to plug in two barrel jacks?

Some sensors and devices operate on 3.3V or other lower special power supply. The arduino is 5V. so we would need to have our own power supply and using logic level shifters.

## LCD Shields nee to be on top.
So I like to use an LCD. and the up down, left, right, select button. and usually at least another button. like for back or cancel. and then you want a rest button. and then you want some spare user defined buttons.

But a LCD is big. I like those 20x4 kind. Practically you can only fit a 16x2 LCD onto a regular shield size. Unless we use a finer dot pitched display. or an OLED display . Those are pretty sweet. But they also tend to cost more so most people wouldn't want to have to buy these.

But what it is looking like here in this thoughtful interactive design stream of consciousness is that we really are looking to build more than one shield here.
Though the Adafruit I2C LCD keypad shield is pretty neat. It is what I would probably end up building anyway. So if I want a good LCD shield, I would probably just buy that one.