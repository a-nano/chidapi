# chidapi

## Instllation
1.Install [signal11/hidapi](https://github.com/signal11/hidapi)

<br>

2. Clone to your local-projects.
```sh
$ cd $HOME/quicklsp/local-projects
$ git clone https://github.com/a-nano/chidapi.git
```

or use ros install
```sh
$ ros install a-nano/chidapi
```

3. Start your lis. Then, just:
```common-lisp
(ql:quickload :chidapi)
```

## Usage

```common-lisp
(chidapi:enumerate)

=>
((:INTERFACE-NUMBER -1 :USAGE 2 :USAGE-PAGE 1 :PRODUCT-STRING
  "USB Optical Mouse" :MANUFACTURER-STRING "PixArt" :RELEASE-NUMBER 256
  :SERIAL-NUMBER NIL :PRODUCT-ID 9488 :VENDOR-ID 2362 :PATH
  "\\\\?\\hid#vid_093a&pid_2510#6&1de692fe&0&0000#{4d1e55b2-f16f-11cf-88cb-001111000030}")
 (:INTERFACE-NUMBER -1 :USAGE 1 :USAGE-PAGE 12 :PRODUCT-STRING NIL
  :MANUFACTURER-STRING NIL :RELEASE-NUMBER 1 :SERIAL-NUMBER NIL :PRODUCT-ID
  2352 :VENDOR-ID 22116 :PATH
  "\\\\?\\hid#tossyshid&col01#4&b2a0d9&0&0000#{4d1e55b2-f16f-11cf-88cb-001111000030}"))
```
## Functions
enumerate -> string
<br>
get-indexed-string device -> string
<br>
get-manufacturer-string device -> string
<br>
get-product-string device -> string
<br>
get-serial-number-string device -> string 
<br>
write-buffer device index value -> (integer 0 255)
<br>
read-buffer device index &key timeout -> (integer 0 255)
<br>

## Macros
with-hid-device (device &key vender-id product-id serial-number path) &body body

## Depends
 [signal11/hidapi](https://github.com/signal11/hidapi)


## Author
* Akihide Nano (an74abc@gmail.com)

## Copyright
Copyright (c) 2018 Akihide Nano (an74abc@gmail.com)

## License
Licensed under the LLGPL License.