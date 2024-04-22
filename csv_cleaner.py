import csv

"""
+1 for every int id in vertex csv
delimiter changed from | to ,

forum has member person
person knows person

person likes comment
person study at organization
person work at organisation

"""

import re
# # Open the input and output files
with open('/home/zainab/social_network-sf1-CsvComposite-LongDateFormatter/dynamic/comment_0_0.csv', 'r') as infile, open('/home/zainab/age-benchmark-dataset/sf-1/dynamic/comment_0_0.csv', 'w', newline='') as outfile:
    reader = csv.reader(infile, delimiter='|')
    writer = csv.writer(outfile, delimiter=',')
    count = 0

    # Iterate over each row in the input file
    for row in reader:
        if count != 0:
        # Convert the first element (id) to an integer and add 1
            row[0] = str(int(row[0]) + 1)
            # Write the modified row to the output file
            if re.search('About Old Alabama, 0 buildings on the site', row[4]):
                print('yes')
                row[4] = ''
            writer.writerow(row)
        else:
            writer.writerow(row)   
        count += 1

# start_id,start_vertex_type,end_id,end_vertex_type
# # Open the input and output files
# with open('/home/zainab/social_network-sf1-CsvComposite-LongDateFormatter/dynamic/post_isLocatedIn_place_0_0.csv', 'r') as infile, open('/home/zainab/age-benchmark-dataset/sf-1/dynamic/post_isLocatedIn_place_0_0.csv', 'w', newline='') as outfile:
#     reader = csv.reader(infile, delimiter='|')
#     writer = csv.writer(outfile, delimiter=',')
#     count = 0

#     # Iterate over each row in the input file
#     for row in reader:
#         # print(row)
#         if count != 0:
#         # Convert the first element (id) to an integer and add 1
#             end_v = row[1]
#             row[0] = str(int(row[0]) + 1)
#             row[1] = 'Post'
#             # Write the modified row to the output file
#             if len(row) == 2:
#                 writer.writerow(row[0:2]+[str(int(end_v) + 1)]+['Place'])
#             else:
#                 writer.writerow(row[0:2]+[str(int(end_v) + 1)]+['Place']+row[2:])
#         else:
#             if len(row) == 2:
#                 writer.writerow(['start_id','start_vertex_type','end_id','end_vertex_type'])
#             else:
#                 writer.writerow(['start_id','start_vertex_type','end_id','end_vertex_type']+row[2:])
#         count += 1