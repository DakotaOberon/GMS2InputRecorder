# GMS2InputRecorder
 
Record and play back user input.

![Record and Playback Example](https://media3.giphy.com/media/HeXY8Do0OD0F7VCIVC/giphy.gif?cid=790b76115c392c1b21093114e35d027256cdeddd66746cd2&rid=giphy.gif&ct=g)

This is based on the GDC talk [Automated Testing and Instant Replays in Retro City Rampage](https://www.youtube.com/watch?v=W20t1zCZv8M) which shows the many ways recording user input can be used to create fun and exciting moments in games.

GameMaker only allows reading and writing in buffer_u8 which is equivelant to a byte of data, 8 times bigger than what we need.
To get around this limitation, I use bitwise operators to shift bits into place inside the buffer.
This allows for very minimal data to be used when recording user input.

Each stream uses 1 bit per frame (60 bits per seconds at default frame rate)

That means that if you recorded 1 minute of user gameplay across 4 input streams, you would only be using 14.4 kb of memory to hold it or store it in a file

*** NOTE: This code is very early and uncommented, I will be optimizing, testing, and documenting this system over time ***

*** This uses [JujuAdams Input extension](https://github.com/JujuAdams/input) ***
