# Notes:

## Example bash calls:

- `ruby FlipPancakes.rb 5 - -+ +- +++ --+-`
  - **Counts:** 1, 1, 2, 0, 3
- `ruby FlipPancakes.rb 6 - -+ +- +++ --+- ++-+---++-+---++-+---++-+---++-+---++-+---++-+---++-+---++-+---++-+---++-+---++-+---++-+---++-+---++`
  - **Counts:** 1, 1, 2, 0, 3, 56

---

## Any Patterns?

Let's find some patterns...

```
# Rule #1:
#   Turn the bottom pancakes happy ASAP
#     [---]+- NOPE
#     [---+-] YEP
#
# Rule #2: NEED A HAPPY BOTTOM
#   Never flip un-happy bottom pancake to another un-happy pancake
#     [+--+-] NOPE
#     [+--+]- YEP
#
# Rule #3: NEED A HAPPY BOTTOM
#   If first & last pancakes are un-happy, flip the full stack
#     [-]++-- NOPE
#     [-++--] YEP
#
# Rule #4:
#   Never unflip *ANY* happy bottom pancakes
#     [+--+-+] NOPE
#           ^ leave this untouched
#     [+---+]+ NOPE
#          ^ leave this untouched
#
# Rule #5:
#   Always end group with same symbol as top pancake, OR only flip top pancake
#     BOTH have same amount of steps:
#       [+--+]-+ YEP (#1)
#       [+]--+-+ YEP (#2)
#     Example #1:
#       [+--+]-+ 1
#         -++--+
#         [-++--]+ 2
#           ++--++
#           [++]--++ 3
#             ----++
#             [----]++ 4
#               ++++++
#     Example #2:
#       [+]--+-+ 1
#         ---+-+
#         [---+-]+ 2
#           +-++++
#           [+]-++++ 3
#             --++++
#             [--]++++ 4
#               ++++++
#     

# --+-+
# [--+-]+ 1
#   +-+++
#   [+]-+++ 2
#     --+++
#     [--]+++ 3
#       +++++

# +--+-+
# # [+--+-]+ 1 • NOPE
# #   +-++-+ • Rule #1: Always end stack with same symbol as top pancake
# # [+--+-+] 1 • NOPE
# #   -+-++- • Rule #2: Never unflip happy bottom pancakes
# [+--+]-+ 1
#   -++--+
#   [-]++--+ 2
#     +++--+
#     [+++]--+ 3
#       -----+
#       [-----]+ 4
#         ++++++
#   [-++--]+ 2 # This follows Rule #1, and ends with same number of flips
#     ++--++
#     [++]--++ 3
#       ----++
#       [----]++ 4
#         ++++++

# ---++
# [---]++
#     +++++ 1

# ---+-
# [---+-] 1
#   +-+++
#   [+]-+++ 2
#     --+++
#     [--]+++ 3
#       +++++
# # [---]+- 1 • NOPE
# #   ++++- • Rule #3: Turn the bottom pancakes happy ASAP
# #   [++++-] 2
# #     +----

# +--+-
# # [+--+-] 1 • NOPE
# #   +-++- • Rule #4: Never flip un-happy bottom pancake to another un-happy pancake
# [+--+]- 1
#   -++--
#   [-]++-- 2
#     +++--
#     [+++--] 3
#       ++---
#       [++]--- 4
#         -----
#         [-----] 5
#           +++++

# --++-
# [--++-] 1
#   +--++
#   [+]--++ 2
#     ---++
#     [---]++ 3
#       +++++


# Case 5 stack:
# --+-
# [--]+- 1
#   +++-
#   [+++]- 2
#     ----
#     [----] 3
#       ++++
# --+-
# [--+-] 1
#   +-++
#   [+]-++ 2
#     --++
#     [--]++ 3
#       ++++
# ????? I dunno ?????
# Case #5: 3
# New stack:
# --+-
# --+-
#
# ++-+
```

---

## Minitest?

I dont' believe we want this to auto-run tests, as bash input is requested

```
require 'minitest/autorun'
class FlipPancakes < Minitest::Test
  # Run any functionality here
  def flip_faceup(stack)
    # TODO
  end

  # Run tests here:
  def test_first
    # TODO
  end

  def test_second
    # TODO
  end
  # etc...
end
```
