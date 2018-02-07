# PSEUDO CODE

# Go forward through the last found array                     ###### [7,4]                 ##### [11]                  #### [8,1,1,1]              ### [6,3,1,1]             # [6,2,1,1,1]             # [6,4,1]
  # If the number is NOT a 1 AND it's not the last item in the last array found, 
    # add it to the next part array                           ###### next_part_array = [7] ### next_part_array = [8]   ### next_part_array = [6,3] # next_part_array = [6,2] # next_part_array = [6,4]

  # If the number IS the first one,                           #### [8]                     ### [6,3,1]                 # [6,2,1]                 # [6,4,1]
    # set the first_non_one to the position previous - 1      #### first_non_one = 7       ### first_non_one = 2       # first_non_one = 1       # first_non_one = 3
    # remove the last item added to the next part array       #### next_part_array = []    ### next_part_array = [6]   # next_part_array = [6]   # next_part_array = [6]
    # add the first_non_one to the next part array            #### next_part_array = [7]   ### next_part_array = [6,2] # next_part_array = [6,1] # next_part_array = [6,3]
    # sum the remaining ones current pos to end + 1           #### one_count = 4           ### one_count = 3           # one_count = 4           # one_count = 2 

    # if first_non_one == 1
      # set first_non_one to new position                               # first_non_one = k-2
      # one count times add 1 to the end of the next_part_array         # next_part_array = [6,1,1,1,1,1]

    # elsif first_non_one > 1                                           #### first_non_one = 7, one_count = 4  ### first_non_one = 2, one_count = 3  ## first_non_one = 3, one_count = 2
      # until one_count == 0
        # if one_count <= first_non_one && one_count != 1
          # add sum of one count to the next position in the array.     #### [7,4]              ## [6,3,2]
          # reset first_non_one to be the one count                     #### first_non_one = 4  ## first_non_one = 2
          # reset one_count                                             #### one_count = 0      ## one_count = 0

        # elsif one_count <= first_non_one && one_count == 1            ### one_count = 1 < first_non_one = 2
          # add sum of one count to the next position in the array.     ### next_part_array = [6,2,2,1]
          # reset one_count = 0                                         ### one_count = 1

        # else (one_count > first_non_one)                              ### first_non_one = 2, one_count = 3
          # enter the sum (first_non_one) into the next_part_array      # next_part_array = [6,1,1]                ### next_part_array = [6,2,2]
          # first_non_one remains the same                              # first_non_one = 1                        ### first_non_one = 2
          # subtract first_non_one from the one_count                   # one_count = 4 - first_non_one = 1 = 3    ### 3-2 = 1
          # reset one_count to result of subtraction                    # one_count = 4-1 = 3                      ### one_count = 3-2 = 1
        # end

  # If the number is NOT a 1 AND it IS the last item in the last array found,
    # set first_non_one to current position - 1               ###### first_non_one = 3         ##### first_non_one = 10
    # add the first_non_one to the next part array            ###### next_part_array = [7,3]   ##### next_part_array = [10]
    # add one to the next part array                          ###### next_part_array = [7,3,1] ##### next_part_array = [10, 1]
  
  # add the next part array to the array being returned
  # increase the position count

# CODE
def part(n)
  enum_arr = enum(n)
  prod_arr = prod(enum_arr)
  fin_range = range(prod_arr)
  fin_avg = average(prod_arr)
  fin_median = median(prod_arr)
  p "Range: #{fin_range} Average: #{fin_avg} Median: #{fin_median}"
end

# return as integer
def range(prod_arr)
  prod_arr.last - prod_arr.first
end

# float to two dec
def average(prod_arr)
  '%.2f' % [ prod_arr.inject(:+)/prod_arr.length.to_f ]
end

# float to two dec
def median(prod_arr)
  if prod_arr.length.odd?
    '%.2f' % [ prod_arr[prod_arr.length / 2].to_f ]
  else
    '%.2f' % [ (prod_arr[prod_arr.length/2-1] + prod_arr[prod_arr.length/2])/2.to_f ]
  end
end

def prod(enum_arr)
  enum_arr.map { |x| x.inject(:*) }.uniq.sort
end

def enum(n)
  all_parts = [[n]]
  k = 0
  first_non_one = 0
  one_count = 0
  until all_parts[k][0] == 1
    next_part = Array.new
    for i in 0..all_parts[k].length
      # If the number is NOT a 1, and it's not the last item in the array found
      if all_parts[k][i] != 1 && i < all_parts[k].length
        # add it to the next part array 
        next_part << all_parts[k][i]
      # If the number IS the first one,
      else
        # set the first_non_one to the position previous - 1
        first_non_one = all_parts[k][i-1] - 1
        # remove the last item added to the next part array
        next_part.pop
        # add the first_non_one to the next part array
        next_part.push(first_non_one)
        # sum the remaining ones current pos to end + 1  
        one_count = all_parts[k].length - i + 1
        # until one_count == 0
        until one_count == 0
          # if one_count <= first_non_one && one_count != 1
          if one_count <= first_non_one && one_count != 1
            # add sum of one count to the next position in the array.
            next_part << one_count
            # reset first_non_one to be the same as the one count 
            first_non_one = one_count
            # reset one_count 
            one_count = 0
          # elsif one_count <= first_non_one && one_count == 1 
          elsif one_count <= first_non_one && one_count == 1
            # add sum of one count to the next position in the array.
            next_part << one_count
            # reset one_count = 0 
            one_count = 0
          # else (one_count > first_non_one)
          else 
            # enter the sum (first_non_one) into the next_part_array
            next_part << first_non_one
            # first_non_one remains the same  
            # reset one_count # subtract first_non_one from the one_count
            one_count = one_count - first_non_one
          # end
          end
        end
        next_part
        break
      end
      # If the number is NOT a 1 AND it IS the last item in the last array found,
      if all_parts[k][i] != 1 && i == all_parts[k].length
        # set first_non_one to current position - 1
        first_non_one = all_parts[k][i]-1
        # add the first_non_one to the next part array 
        next_part_array << first_non_one
        # add one to the next part array
        next_part_array << 1
      end
    end
    # Go forward through the last found array
    # increase the position count
    k += 1
    # add the next part array to the array being returned
    all_parts << next_part
  end
  all_parts
end

# OTHER SOLUTIONS

# while true
#   while (k >= 0 && whole_part[k] == 1)
#     p 'here'
#     rem_val += whole_part[k]
#     k -= 1
#     p 'K is ...'
#     p k
#   end
#   if k < 0
#     return ret_parts
#   end
#   whole_part[k] -= 1 # 5
#   rem_val += 1 # 1
#   while rem_val > whole_part[k]
#     whole_part[k+1] = whole_part[k]
#     rem_val = rem_val - whole_part[k]
#     k += 1
#   end
#   whole_part[k+1] = rem_val
#   k += 1
# end

# DRIVER CODE
# p part3(5) # SUPPLIED TEST [[5],[4,1],[3,2],[3,1,1],[2,2,1],[2,1,1,1],[1,1,1,1,1]]
# MY ANSWER [[4, 1], [3, 2], [3, 1, 1], [2, 2, 1], [2, 1, 1, 1], [1, 1, 1, 1, 1]]
# p prod([[5], [4, 1], [3, 2], [3, 1, 1], [2, 2, 1], [2, 1, 1, 1], [1, 1, 1, 1, 1]])
p part(5)

# p part3(6)
# p part3(7) # ERROR, MISSING [3,2,2] ## [[6, 1], [5, 2], [5, 1, 1], [4, 3], [4, 2, 1], [4, 1, 1, 1], [3, 3, 1], [3, 2, 1, 1], [3, 1, 1, 1, 1], [2, 2, 2, 1], [2, 2, 1, 1, 1], [2, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1]]
# SOLVED!
# p prod([[7], [6, 1], [5, 2], [5, 1, 1], [4, 3], [4, 2, 1], [4, 1, 1, 1], [3, 3, 1], [3, 2, 2], [3, 2, 1, 1], [3, 1, 1, 1, 1], [2, 2, 2, 1], [2, 2, 1, 1, 1], [2, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1]])
# [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12]
p part(7)

start = Time.now
p part(50)
finish = Time.now
diff = finish - start
p diff

start = Time.now
p part(60)
finish = Time.now
diff = finish - start
p diff

# p part3(11) # NOT WORKING, PRY HAS TO DO WITH ATTEMPTED FIX TO PART(7)
  # [[10, 1], [9, 2], [9, 1, 1], [8, 3], [8, 2, 1], [8, 1, 1, 1], [7, 4], [7, 3, 1], [7, 2, 2], [7, 2, 1, 1], [7, 1, 1, 1, 1], [6, 5], [6, 4, 1], 

  # [6, 3, 1, 1], 

  # [6, 2, 1, 1, 1], [6, 1, 1, 1, 1, 1], [5, 5, 1], [5, 4, 1, 1], [5, 3, 2, 1], [5, 3, 1, 1, 1], [5, 2, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1], [4, 4, 3], [4, 4, 2, 1], [4, 4, 1, 1, 1], [4, 3, 1, 1, 1, 1], [4, 2, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1], [3, 3, 3, 2], [3, 3, 3, 1, 1], [3, 3, 2, 1, 1, 1], [3, 3, 1, 1, 1, 1, 1], [3, 2, 1, 1, 1, 1, 1, 1], [3, 1, 1, 1, 1, 1, 1, 1, 1], [2, 2, 2, 2, 2, 1], [2, 2, 2, 2, 1, 1, 1], [2, 2, 2, 1, 1, 1, 1, 1], [2, 2, 1, 1, 1, 1, 1, 1, 1], [2, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]]
# MISSING [6,3,2], [6,2,2,1], 
# [[11], [10, 1], [9, 2], [9, 1, 1], [8, 3], [8, 2, 1], [8, 1, 1, 1], [7, 4], [7, 3, 1], [7, 2, 2], [7, 2, 1, 1], [7, 1, 1, 1, 1], [6, 5], [6, 4, 1], [6, 3, 2], [6, 3, 1, 1], [6, 2, 2, 1], [6, 2, 1, 1, 1], [6, 1, 1, 1, 1, 1], [5, 5, 1], [5, 4, 2], [5, 4, 1, 1], [5, 3, 3], [5, 3, 2, 1], [5, 3, 1, 1, 1], [5, 2, 2, 2], [5, 2, 2, 1, 1], [5, 2, 1, 1, 1, 1], [5, 1, 1, 1, 1, 1, 1], [4, 4, 3], [4, 4, 2, 1], [4, 4, 1, 1, 1], [4, 3, 3, 1], [4, 3, 2, 2], [4, 3, 2, 1, 1], [4, 3, 1, 1, 1, 1], [4, 2, 2, 2, 1], [4, 2, 2, 1, 1, 1], [4, 2, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 1, 1, 1], [3, 3, 3, 2], [3, 3, 3, 1, 1], [3, 3, 2, 2, 1], [3, 3, 2, 1, 1, 1], [3, 3, 1, 1, 1, 1, 1], [3, 2, 2, 2, 2], [3, 2, 2, 2, 1, 1], [3, 2, 2, 1, 1, 1, 1], [3, 2, 1, 1, 1, 1, 1, 1], [3, 1, 1, 1, 1, 1, 1, 1, 1], [2, 2, 2, 2, 2, 1], [2, 2, 2, 2, 1, 1, 1], [2, 2, 2, 1, 1, 1, 1, 1], [2, 2, 1, 1, 1, 1, 1, 1, 1], [2, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]]


















