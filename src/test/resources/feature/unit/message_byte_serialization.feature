@unit-test
Feature: Serialize messages to byte lists

  Scenario Outline: Gossip announce message byte serialization
    Given a gossip announce message with "<ttl>" and "<datatype>" and "<payload>"
    When the message is serialized
    Then the following byte sequence is returned: "<byteSequence>"
    Examples:
      | ttl  | datatype | payload                          | byteSequence                                                                       |
      | 1    | 1234     | 571e72a5c0e6d751df489389e7986193 | 002801F4010004D23537316537326135633065366437353164663438393338396537393836313933 |
      | 503  | 9        | 92a8d77cae2579314736837969035532 | 002801F4F70000093932613864373763616532353739333134373336383337393639303335353332 |
      | 9999 | 800      | 0c9823ba4759e89a3987630236d4     | 002401F40F00032030633938323362613437353965383961333938373633303233366434         |
      | 7    | 1        | 0fff                             | 000C01F40700000130666666                                                         |

  Scenario: Gossip notify message byte serialization
    Given a Gossip Notify Message
    When the message is serialized
    Then the following byte sequence is returned: "00 08 01 F5 00 00 02 1E"

  Scenario Outline: Gossip notification message byte serialization
    Given a gossip notification message with "<datatype>" and "<payload>"
    When the message is serialized
    Then the following byte sequence is returned: "<byteSequence>"
    Examples:
      | datatype | payload                          | byteSequence                                                                         |
      | 1234     | 5a1e72a5c0e6d751df489389e7986193 | 002801F6000004D23561316537326135633065366437353164663438393338396537393836313933 |
      | 9        | 9218d77cae2579314736837969035532 | 002801F6000000093932313864373763616532353739333134373336383337393639303335353332 |
      | 800      | 0c9823ba4739e89a3987630236d4     | 002401F60000032030633938323362613437333965383961333938373633303233366434         |
      | 1        | 0fff                             | 000C01F60000000130666666                                                         |

  Scenario: Query message byte serialization
    Given an NSE Query Message
    When the message is serialized
    Then the following byte sequence is returned: "00 04 02 08"

  Scenario Outline: Estimation message byte serialization
    Given an NSE estimation Message with estimated size "<size>" and standard deviation "<standardDeviation>"
    When the message is serialized
    Then the following byte sequence is returned: "<byteSequence>"
    Examples:
      | size       | standardDeviation | byteSequence                        |
      | 1000       | 15                | 00 0C 02 09 00 00 03 E8 00 00 00 0F |
      | 9999       | 5                 | 00 0C 02 09 00 00 27 0F 00 00 00 05 |
      | 0          | 0                 | 00 0C 02 09 00 00 00 00 00 00 00 00 |
      | 4294967295 | 65535             | 00 0C 02 09 FF FF FF FF 00 00 FF FF |

  Scenario: RPS Query message byte serialization
    Given an RPS Query Message
    When the message is serialized
    Then the following byte sequence is returned: "00 04 02 1C"

  Scenario Outline: RPS Peer message byte serialization
    Given an RPS message with "<ip>" and "<digest>" and "<port>"
    When the message is serialized
    Then the following byte sequence is returned: "<byteSequence>"
    Examples:
      | ip                   | digest                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | port | byteSequence                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | 192.168.1.1          | MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAxMwNFe+C2+jKtRew52DLW6Sc5F1Lb4mer9Ffy6GgjzkHtdg0lynt9FbZdCSAfcGsiwsPLHKJau6ED932XuLvutmO2Ys0TjL1aBi0rHsLqoXG7ek+BrsSraETQK3rJFvGddF2E009/sM8CnFD4FjjJ8LF5/i5WAGiW9J0IiSBzXokIR+whSLiqP+X1KzKC446FHNvBvklaObfxDL2tr82ST4qqWq8h08y0J5qG1FkW9CMYrIracHzrvNc4y6DXkAZKJ2tvIwAelNILoOagAcg9Y3Mtqob162sJaNzJwgAo1vmkifMY9GSCEH72dwamToKQThSOh46QmwFWH5JCjGTH9Qlo9fz/jol6FL+ER2TQ66VsVIbChRyHenJ9gclokLOE4TutkkjE7iZjLasT1nv06nws4KbnUVjQ7SPQfm/W3rqP8tzu8EaKivbAW/AM+myLQNcGEW6jPb6y8mRkJQl/nYNGU1BhYngGp1kR9uF1gfAiB8hVfqS+ZZsqH8cKXXnGapwsCEmCvdM/sZR0zQJWk+Wta/oEawMWI9D29K4d887fpwt0JyuEDFS6FfLf8K/xVmq/pVALIUGlaJTw968ikTgWFiisMX63kj0WN3BD9iykSbn45n9zWrD/sjQuK9Lo4dZwiA2Wwx7mNrhSBl8+WOdjVnUr4v+HwnKKhHmvDsCAwEAAQ== | 9090 | 0232021D23820004C0A8010130820222300D06092A864886F70D01010105000382020F003082020A0282020100C4CC0D15EF82DBE8CAB517B0E760CB5BA49CE45D4B6F899EAFD15FCBA1A08F3907B5D8349729EDF456D97424807DC1AC8B0B0F2C72896AEE840FDDF65EE2EFBAD98ED98B344E32F56818B4AC7B0BAA85C6EDE93E06BB12ADA11340ADEB245BC675D176134D3DFEC33C0A7143E058E327C2C5E7F8B95801A25BD274222481CD7A24211FB08522E2A8FF97D4ACCA0B8E3A14736F06F92568E6DFC432F6B6BF36493E2AA96ABC874F32D09E6A1B51645BD08C62B22B69C1F3AEF35CE32E835E4019289DADBC8C007A53482E839A800720F58DCCB6AA1BD7ADAC25A373270800A35BE69227CC63D1920841FBD9DC1A993A0A4138523A1E3A426C05587E490A31931FD425A3D7F3FE3A25E852FE111D9343AE95B1521B0A14721DE9C9F60725A242CE1384EEB6492313B8998CB6AC4F59EFD3A9F0B3829B9D456343B48F41F9BF5B7AEA3FCB73BBC11A2A2BDB016FC033E9B22D035C1845BA8CF6FACBC991909425FE760D194D418589E01A9D6447DB85D607C0881F2155FA92F9966CA87F1C2975E719AA70B021260AF74CFEC651D334095A4F96B5AFE811AC0C588F43DBD2B877CF3B7E9C2DD09CAE103152E857CB7FC2BFC559AAFE95402C850695A253C3DEBC8A44E05858A2B0C5FADE48F458DDC10FD8B29126E7E399FDCD6AC3FEC8D0B8AF4BA38759C220365B0C7B98DAE148197CF9639D8D59D4AF8BFE1F09CA2A11E6BC3B0203010001                         |
      | 127.0.0.1            | MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAkjbux3IwjEaPMPmguWzOw/7wC902ztY6HhyOsfaT/wzvJYizTfpLFiHhxuy6m2miT6s2TjLwsAQAWVxvoWOyV64et1W7lb2F8A5uoPeCGN/ij08L5uKA+z6xqit9D3A7qvrNS6nC1XzB4BkM/PyhkFm2g/xUwgxWJkcTQXik2hW/Yx8ZEhWwh50GWnWm9BVJarHRBeTXnlWom4LV4RHi1himDp0XPzlFuSA0E78tyhiAGh+UawtRch4UuiNUPn98dv30bRmv0Tbup4fifQcOZwYUh+X2M4f8WdiWOpWtm5PTjFt1OqYG71u9dMCByhRo1IMTnq0MPJYNaGhGOaiS3z6EecpzOQNu1KbC9KBses3lBt5rU5NCT0RLvNn4PN7TgJE2cS5mTd32gQ0JSHUwARpZi2Or78omYlwjeuZdKBV2IT8pITUOdfPGrmGIkFWKOBUDfjWC8je9q1GXqwwB775kLBcsP1vx1EnIZuXvrpYiYaDVofhy6JyJ50XV55dMwaZ0hbncmVAFeAAY7XHHltiagNHIuDtoeXAYgbagnXet4tNtIJt4SEx/KAYMGPcrEFARBAupxG9qGkjFtThzHL07mSO8NA2YrL+Zj39cLU9ygfHcTvis9VWxzG3/mOMeh1OoJ/lX1hpnbhi7rrKGx168tK4LzXx0qO3GGfnvJT8CAwEAAQ== | 4444 | 0232021D115C00047F00000130820222300D06092A864886F70D01010105000382020F003082020A02820201009236EEC772308C468F30F9A0B96CCEC3FEF00BDD36CED63A1E1C8EB1F693FF0CEF2588B34DFA4B1621E1C6ECBA9B69A24FAB364E32F0B00400595C6FA163B257AE1EB755BB95BD85F00E6EA0F78218DFE28F4F0BE6E280FB3EB1AA2B7D0F703BAAFACD4BA9C2D57CC1E0190CFCFCA19059B683FC54C20C562647134178A4DA15BF631F191215B0879D065A75A6F415496AB1D105E4D79E55A89B82D5E111E2D618A60E9D173F3945B9203413BF2DCA18801A1F946B0B51721E14BA23543E7F7C76FDF46D19AFD136EEA787E27D070E67061487E5F63387FC59D8963A95AD9B93D38C5B753AA606EF5BBD74C081CA1468D483139EAD0C3C960D68684639A892DF3E8479CA7339036ED4A6C2F4A06C7ACDE506DE6B5393424F444BBCD9F83CDED3809136712E664DDDF6810D09487530011A598B63ABEFCA26625C237AE65D281576213F2921350E75F3C6AE618890558A3815037E3582F237BDAB5197AB0C01EFBE642C172C3F5BF1D449C866E5EFAE962261A0D5A1F872E89C89E745D5E7974CC1A67485B9DC995005780018ED71C796D89A80D1C8B83B6879701881B6A09D77ADE2D36D209B78484C7F28060C18F72B105011040BA9C46F6A1A48C5B538731CBD3B9923BC340D98ACBF998F7F5C2D4F7281F1DC4EF8ACF555B1CC6DFF98E31E8753A827F957D61A676E18BBAEB286C75EBCB4AE0BCD7C74A8EDC619F9EF253F0203010001                         |
      | 2001:cdba::3257:9652 | MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA1X6FEI/XselcYXWLUHGCWPw9Ie6Tl/XUKApG/1kkHJbjgKAqTDFMwnvuY1p16UxU26R49qMoYiZJxHKJ1nu7mM9lqCYh+b8V7y9IExP22/dpo4Trf7A/KGhNovQnewTkcLaX9ume/hwoo9sBoJO/ZxUUxPPHLS352DB4YRFQbqnPYU4GQSr3miBWEA6MSDKZbSrC+NsLcRtzySKkZpkgh7rpNzIBdBhGcjHA9jPS8v4FVSqOcRiAUvKkF58UiElqm7GQSv12nF8nISYzJ0K1dakAp1+OnWS3ONywU9THQTgkx/kEmB0avo3DPr0avkNRpVDvRCd9nfOSlGceeNxyDnOLoLLqZZjbsW+Eff3QweYimG2Vhs9f4aaNxlKlgs31MjI/A19xOZtIpvniLfW/zmoxjLqaiXDX8ABvToKKFH7N04A+6tUnt+q71sTwzg+l6a3JLgQGIjEf+8wQ9qRa/1YjbjSsVv2dQjSCLXAf99wAg9BiMNLtCu0qsfR95I2SsGIMtASeTu0EBzJ/D72UmFRs99uLJfMKA8U0Dc6hg4l83MO8BfY5681Jhisgq80bHhG9N8K2jFZwQ7u7IyzeFVdo0PWm/Q11bHnT21pZLRzJw36jpOgZwHbRij03+mnLSX848tE8Ve+mSyVtYY7BA1ctKqsLXoXbpEHOkjMPdDcCAwEAAQ== | 8080 | 023E021D1F9000062001CDBA00000000000000003257965230820222300D06092A864886F70D01010105000382020F003082020A0282020100D57E85108FD7B1E95C61758B50718258FC3D21EE9397F5D4280A46FF59241C96E380A02A4C314CC27BEE635A75E94C54DBA478F6A328622649C47289D67BBB98CF65A82621F9BF15EF2F481313F6DBF769A384EB7FB03F28684DA2F4277B04E470B697F6E99EFE1C28A3DB01A093BF671514C4F3C72D2DF9D830786111506EA9CF614E06412AF79A2056100E8C4832996D2AC2F8DB0B711B73C922A466992087BAE93732017418467231C0F633D2F2FE05552A8E71188052F2A4179F1488496A9BB1904AFD769C5F272126332742B575A900A75F8E9D64B738DCB053D4C7413824C7F904981D1ABE8DC33EBD1ABE4351A550EF44277D9DF39294671E78DC720E738BA0B2EA6598DBB16F847DFDD0C1E622986D9586CF5FE1A68DC652A582CDF532323F035F71399B48A6F9E22DF5BFCE6A318CBA9A8970D7F0006F4E828A147ECDD3803EEAD527B7EABBD6C4F0CE0FA5E9ADC92E040622311FFBCC10F6A45AFF56236E34AC56FD9D4234822D701FF7DC0083D06230D2ED0AED2AB1F47DE48D92B0620CB4049E4EED0407327F0FBD9498546CF7DB8B25F30A03C5340DCEA183897CDCC3BC05F639EBCD49862B20ABCD1B1E11BD37C2B68C567043BBBB232CDE155768D0F5A6FD0D756C79D3DB5A592D1CC9C37EA3A4E819C076D18A3D37FA69CB497F38F2D13C55EFA64B256D618EC103572D2AAB0B5E85DBA441CE92330F74370203010001 |
      | ::1                  | MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAxMwNFe+C2+jKtRew52DLW6Sc5F1Lb4mer9Ffy6GgjzkHtdg0lynt9FbZdCSAfcGsiwsPLHKJau6ED932XuLvutmO2Ys0TjL1aBi0rHsLqoXG7ek+BrsSraETQK3rJFvGddF2E009/sM8CnFD4FjjJ8LF5/i5WAGiW9J0IiSBzXokIR+whSLiqP+X1KzKC446FHNvBvklaObfxDL2tr82ST4qqWq8h08y0J5qG1FkW9CMYrIracHzrvNc4y6DXkAZKJ2tvIwAelNILoOagAcg9Y3Mtqob162sJaNzJwgAo1vmkifMY9GSCEH72dwamToKQThSOh46QmwFWH5JCjGTH9Qlo9fz/jol6FL+ER2TQ66VsVIbChRyHenJ9gclokLOE4TutkkjE7iZjLasT1nv06nws4KbnUVjQ7SPQfm/W3rqP8tzu8EaKivbAW/AM+myLQNcGEW6jPb6y8mRkJQl/nYNGU1BhYngGp1kR9uF1gfAiB8hVfqS+ZZsqH8cKXXnGapwsCEmCvdM/sZR0zQJWk+Wta/oEawMWI9D29K4d887fpwt0JyuEDFS6FfLf8K/xVmq/pVALIUGlaJTw968ikTgWFiisMX63kj0WN3BD9iykSbn45n9zWrD/sjQuK9Lo4dZwiA2Wwx7mNrhSBl8+WOdjVnUr4v+HwnKKhHmvDsCAwEAAQ== | 7777 | 023E021D1E6100060000000000000000000000000000000130820222300D06092A864886F70D01010105000382020F003082020A0282020100C4CC0D15EF82DBE8CAB517B0E760CB5BA49CE45D4B6F899EAFD15FCBA1A08F3907B5D8349729EDF456D97424807DC1AC8B0B0F2C72896AEE840FDDF65EE2EFBAD98ED98B344E32F56818B4AC7B0BAA85C6EDE93E06BB12ADA11340ADEB245BC675D176134D3DFEC33C0A7143E058E327C2C5E7F8B95801A25BD274222481CD7A24211FB08522E2A8FF97D4ACCA0B8E3A14736F06F92568E6DFC432F6B6BF36493E2AA96ABC874F32D09E6A1B51645BD08C62B22B69C1F3AEF35CE32E835E4019289DADBC8C007A53482E839A800720F58DCCB6AA1BD7ADAC25A373270800A35BE69227CC63D1920841FBD9DC1A993A0A4138523A1E3A426C05587E490A31931FD425A3D7F3FE3A25E852FE111D9343AE95B1521B0A14721DE9C9F60725A242CE1384EEB6492313B8998CB6AC4F59EFD3A9F0B3829B9D456343B48F41F9BF5B7AEA3FCB73BBC11A2A2BDB016FC033E9B22D035C1845BA8CF6FACBC991909425FE760D194D418589E01A9D6447DB85D607C0881F2155FA92F9966CA87F1C2975E719AA70B021260AF74CFEC651D334095A4F96B5AFE811AC0C588F43DBD2B877CF3B7E9C2DD09CAE103152E857CB7FC2BFC559AAFE95402C850695A253C3DEBC8A44E05858A2B0C5FADE48F458DDC10FD8B29126E7E399FDCD6AC3FEC8D0B8AF4BA38759C220365B0C7B98DAE148197CF9639D8D59D4AF8BFE1F09CA2A11E6BC3B0203010001 |

  Scenario: RPS Peer View message byte serialization
    Given an RPS view message with:
      | hostkey                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | address     | port |
      | MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAxMwNFe+C2+jKtRew52DLW6Sc5F1Lb4mer9Ffy6GgjzkHtdg0lynt9FbZdCSAfcGsiwsPLHKJau6ED932XuLvutmO2Ys0TjL1aBi0rHsLqoXG7ek+BrsSraETQK3rJFvGddF2E009/sM8CnFD4FjjJ8LF5/i5WAGiW9J0IiSBzXokIR+whSLiqP+X1KzKC446FHNvBvklaObfxDL2tr82ST4qqWq8h08y0J5qG1FkW9CMYrIracHzrvNc4y6DXkAZKJ2tvIwAelNILoOagAcg9Y3Mtqob162sJaNzJwgAo1vmkifMY9GSCEH72dwamToKQThSOh46QmwFWH5JCjGTH9Qlo9fz/jol6FL+ER2TQ66VsVIbChRyHenJ9gclokLOE4TutkkjE7iZjLasT1nv06nws4KbnUVjQ7SPQfm/W3rqP8tzu8EaKivbAW/AM+myLQNcGEW6jPb6y8mRkJQl/nYNGU1BhYngGp1kR9uF1gfAiB8hVfqS+ZZsqH8cKXXnGapwsCEmCvdM/sZR0zQJWk+Wta/oEawMWI9D29K4d887fpwt0JyuEDFS6FfLf8K/xVmq/pVALIUGlaJTw968ikTgWFiisMX63kj0WN3BD9iykSbn45n9zWrD/sjQuK9Lo4dZwiA2Wwx7mNrhSBl8+WOdjVnUr4v+HwnKKhHmvDsCAwEAAQ== | 127.0.0.1   | 8080 |
      | MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAkjbux3IwjEaPMPmguWzOw/7wC902ztY6HhyOsfaT/wzvJYizTfpLFiHhxuy6m2miT6s2TjLwsAQAWVxvoWOyV64et1W7lb2F8A5uoPeCGN/ij08L5uKA+z6xqit9D3A7qvrNS6nC1XzB4BkM/PyhkFm2g/xUwgxWJkcTQXik2hW/Yx8ZEhWwh50GWnWm9BVJarHRBeTXnlWom4LV4RHi1himDp0XPzlFuSA0E78tyhiAGh+UawtRch4UuiNUPn98dv30bRmv0Tbup4fifQcOZwYUh+X2M4f8WdiWOpWtm5PTjFt1OqYG71u9dMCByhRo1IMTnq0MPJYNaGhGOaiS3z6EecpzOQNu1KbC9KBses3lBt5rU5NCT0RLvNn4PN7TgJE2cS5mTd32gQ0JSHUwARpZi2Or78omYlwjeuZdKBV2IT8pITUOdfPGrmGIkFWKOBUDfjWC8je9q1GXqwwB775kLBcsP1vx1EnIZuXvrpYiYaDVofhy6JyJ50XV55dMwaZ0hbncmVAFeAAY7XHHltiagNHIuDtoeXAYgbagnXet4tNtIJt4SEx/KAYMGPcrEFARBAupxG9qGkjFtThzHL07mSO8NA2YrL+Zj39cLU9ygfHcTvis9VWxzG3/mOMeh1OoJ/lX1hpnbhi7rrKGx168tK4LzXx0qO3GGfnvJT8CAwEAAQ== | 192.161.0.1 | 9090 |
      | MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA1X6FEI/XselcYXWLUHGCWPw9Ie6Tl/XUKApG/1kkHJbjgKAqTDFMwnvuY1p16UxU26R49qMoYiZJxHKJ1nu7mM9lqCYh+b8V7y9IExP22/dpo4Trf7A/KGhNovQnewTkcLaX9ume/hwoo9sBoJO/ZxUUxPPHLS352DB4YRFQbqnPYU4GQSr3miBWEA6MSDKZbSrC+NsLcRtzySKkZpkgh7rpNzIBdBhGcjHA9jPS8v4FVSqOcRiAUvKkF58UiElqm7GQSv12nF8nISYzJ0K1dakAp1+OnWS3ONywU9THQTgkx/kEmB0avo3DPr0avkNRpVDvRCd9nfOSlGceeNxyDnOLoLLqZZjbsW+Eff3QweYimG2Vhs9f4aaNxlKlgs31MjI/A19xOZtIpvniLfW/zmoxjLqaiXDX8ABvToKKFH7N04A+6tUnt+q71sTwzg+l6a3JLgQGIjEf+8wQ9qRa/1YjbjSsVv2dQjSCLXAf99wAg9BiMNLtCu0qsfR95I2SsGIMtASeTu0EBzJ/D72UmFRs99uLJfMKA8U0Dc6hg4l83MO8BfY5681Jhisgq80bHhG9N8K2jFZwQ7u7IyzeFVdo0PWm/Q11bHnT21pZLRzJw36jpOgZwHbRij03+mnLSX848tE8Ve+mSyVtYY7BA1ctKqsLXoXbpEHOkjMPdDcCAwEAAQ== | ::1         | 9999 |
    When the message is serialized
    Then the following byte sequence is returned: "069A021E1F9000047F00000130820222300D06092A864886F70D01010105000382020F003082020A0282020100C4CC0D15EF82DBE8CAB517B0E760CB5BA49CE45D4B6F899EAFD15FCBA1A08F3907B5D8349729EDF456D97424807DC1AC8B0B0F2C72896AEE840FDDF65EE2EFBAD98ED98B344E32F56818B4AC7B0BAA85C6EDE93E06BB12ADA11340ADEB245BC675D176134D3DFEC33C0A7143E058E327C2C5E7F8B95801A25BD274222481CD7A24211FB08522E2A8FF97D4ACCA0B8E3A14736F06F92568E6DFC432F6B6BF36493E2AA96ABC874F32D09E6A1B51645BD08C62B22B69C1F3AEF35CE32E835E4019289DADBC8C007A53482E839A800720F58DCCB6AA1BD7ADAC25A373270800A35BE69227CC63D1920841FBD9DC1A993A0A4138523A1E3A426C05587E490A31931FD425A3D7F3FE3A25E852FE111D9343AE95B1521B0A14721DE9C9F60725A242CE1384EEB6492313B8998CB6AC4F59EFD3A9F0B3829B9D456343B48F41F9BF5B7AEA3FCB73BBC11A2A2BDB016FC033E9B22D035C1845BA8CF6FACBC991909425FE760D194D418589E01A9D6447DB85D607C0881F2155FA92F9966CA87F1C2975E719AA70B021260AF74CFEC651D334095A4F96B5AFE811AC0C588F43DBD2B877CF3B7E9C2DD09CAE103152E857CB7FC2BFC559AAFE95402C850695A253C3DEBC8A44E05858A2B0C5FADE48F458DDC10FD8B29126E7E399FDCD6AC3FEC8D0B8AF4BA38759C220365B0C7B98DAE148197CF9639D8D59D4AF8BFE1F09CA2A11E6BC3B0203010001270F00060000000000000000000000000000000130820222300D06092A864886F70D01010105000382020F003082020A0282020100D57E85108FD7B1E95C61758B50718258FC3D21EE9397F5D4280A46FF59241C96E380A02A4C314CC27BEE635A75E94C54DBA478F6A328622649C47289D67BBB98CF65A82621F9BF15EF2F481313F6DBF769A384EB7FB03F28684DA2F4277B04E470B697F6E99EFE1C28A3DB01A093BF671514C4F3C72D2DF9D830786111506EA9CF614E06412AF79A2056100E8C4832996D2AC2F8DB0B711B73C922A466992087BAE93732017418467231C0F633D2F2FE05552A8E71188052F2A4179F1488496A9BB1904AFD769C5F272126332742B575A900A75F8E9D64B738DCB053D4C7413824C7F904981D1ABE8DC33EBD1ABE4351A550EF44277D9DF39294671E78DC720E738BA0B2EA6598DBB16F847DFDD0C1E622986D9586CF5FE1A68DC652A582CDF532323F035F71399B48A6F9E22DF5BFCE6A318CBA9A8970D7F0006F4E828A147ECDD3803EEAD527B7EABBD6C4F0CE0FA5E9ADC92E040622311FFBCC10F6A45AFF56236E34AC56FD9D4234822D701FF7DC0083D06230D2ED0AED2AB1F47DE48D92B0620CB4049E4EED0407327F0FBD9498546CF7DB8B25F30A03C5340DCEA183897CDCC3BC05F639EBCD49862B20ABCD1B1E11BD37C2B68C567043BBBB232CDE155768D0F5A6FD0D756C79D3DB5A592D1CC9C37EA3A4E819C076D18A3D37FA69CB497F38F2D13C55EFA64B256D618EC103572D2AAB0B5E85DBA441CE92330F7437020301000123820004C0A1000130820222300D06092A864886F70D01010105000382020F003082020A02820201009236EEC772308C468F30F9A0B96CCEC3FEF00BDD36CED63A1E1C8EB1F693FF0CEF2588B34DFA4B1621E1C6ECBA9B69A24FAB364E32F0B00400595C6FA163B257AE1EB755BB95BD85F00E6EA0F78218DFE28F4F0BE6E280FB3EB1AA2B7D0F703BAAFACD4BA9C2D57CC1E0190CFCFCA19059B683FC54C20C562647134178A4DA15BF631F191215B0879D065A75A6F415496AB1D105E4D79E55A89B82D5E111E2D618A60E9D173F3945B9203413BF2DCA18801A1F946B0B51721E14BA23543E7F7C76FDF46D19AFD136EEA787E27D070E67061487E5F63387FC59D8963A95AD9B93D38C5B753AA606EF5BBD74C081CA1468D483139EAD0C3C960D68684639A892DF3E8479CA7339036ED4A6C2F4A06C7ACDE506DE6B5393424F444BBCD9F83CDED3809136712E664DDDF6810D09487530011A598B63ABEFCA26625C237AE65D281576213F2921350E75F3C6AE618890558A3815037E3582F237BDAB5197AB0C01EFBE642C172C3F5BF1D449C866E5EFAE962261A0D5A1F872E89C89E745D5E7974CC1A67485B9DC995005780018ED71C796D89A80D1C8B83B6879701881B6A09D77ADE2D36D209B78484C7F28060C18F72B105011040BA9C46F6A1A48C5B538731CBD3B9923BC340D98ACBF998F7F5C2D4F7281F1DC4EF8ACF555B1CC6DFF98E31E8753A827F957D61A676E18BBAEB286C75EBCB4AE0BCD7C74A8EDC619F9EF253F0203010001"