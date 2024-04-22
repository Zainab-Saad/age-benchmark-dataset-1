DROP EXTENSION age CASCADE; CREATE EXTENSION age; LOAD 'age'; SET search_path to ag_catalog; DROP SCHEMA benchmark CASCADE;
SELECT create_graph('benchmark');

SELECT create_vlabel('benchmark', 'Comment');
SELECT create_vlabel('benchmark', 'Person');
SELECT create_vlabel('benchmark', 'Forum');
SELECT create_vlabel('benchmark', 'Post');

SELECT create_elabel('benchmark', 'HAS_CREATOR');
SELECT create_elabel('benchmark', 'HAS_TAG');
SELECT create_elabel('benchmark', 'IS_LOCATED_IN');
SELECT create_elabel('benchmark', 'REPLY_OF');
SELECT create_elabel('benchmark', 'CONTAINER_OF');
SELECT create_elabel('benchmark', 'HAS_MEMBER');
SELECT create_elabel('benchmark', 'HAS_MODERATOR');
SELECT create_elabel('benchmark', 'HAS_TAG');
SELECT create_elabel('benchmark', 'HAS_INTEREST');
SELECT create_elabel('benchmark', 'KNOWS');
SELECT create_elabel('benchmark', 'LIKES');
SELECT create_elabel('benchmark', 'STUDY_AT');
SELECT create_elabel('benchmark', 'WORK_AT');

SELECT create_vlabel('benchmark', 'Organisation');
SELECT create_vlabel('benchmark', 'Place');
SELECT create_vlabel('benchmark', 'Tag');
SELECT create_vlabel('benchmark', 'Tagclass');

SELECT create_elabel('benchmark', 'IS_PART_OF');
SELECT create_elabel('benchmark', 'IS_SUBCLASS_OF');
SELECT create_elabel('benchmark', 'HAS_TYPE');

SELECT load_labels_from_file('benchmark', 'Comment',
'/home/age-benchmark-dataset/sf-1/dynamic/comment_0_0.csv', true, true);

SELECT load_labels_from_file('benchmark', 'Person',
'/home/age-benchmark-dataset/sf-1/dynamic/person_0_0.csv', true, true);

SELECT load_labels_from_file('benchmark', 'Forum',
'/home/age-benchmark-dataset/sf-1/dynamic/forum_0_0.csv', true, true);

SELECT load_labels_from_file('benchmark', 'Post',
'/home/age-benchmark-dataset/sf-1/dynamic/post_0_0.csv', true, true);


SELECT load_edges_from_file('benchmark', 'HAS_CREATOR',
'/home/age-benchmark-dataset/sf-1/dynamic/comment_hasCreator_person_0_0.csv', true);

SELECT load_edges_from_file('benchmark', 'HAS_TAG',
'/home/age-benchmark-dataset/sf-1/dynamic/comment_hasTag_tag_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'IS_LOCATED_IN',
'/home/age-benchmark-dataset/sf-1/dynamic/comment_isLocatedIn_place_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'REPLY_OF',
'/home/age-benchmark-dataset/sf-1/dynamic/comment_replyOf_comment_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'REPLY_OF',
'/home/age-benchmark-dataset/sf-1/dynamic/comment_replyOf_post_0_0.csv', true);

SELECT load_edges_from_file('benchmark', 'CONTAINER_OF',
'/home/age-benchmark-dataset/sf-1/dynamic/forum_containerOf_post_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'HAS_MEMBER',
'/home/age-benchmark-dataset/sf-1/dynamic/forum_hasMember_person_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'HAS_MODERATOR',
'/home/age-benchmark-dataset/sf-1/dynamic/forum_hasModerator_person_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'HAS_TAG',
'/home/age-benchmark-dataset/sf-1/dynamic/forum_hasTag_tag_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'HAS_INTEREST',
'/home/age-benchmark-dataset/sf-1/dynamic/person_hasInterest_tag_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'IS_LOCATED_IN',
'/home/age-benchmark-dataset/sf-1/dynamic/person_isLocatedIn_place_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'KNOWS',
'/home/age-benchmark-dataset/sf-1/dynamic/person_knows_person_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'LIKES',
'/home/age-benchmark-dataset/sf-1/dynamic/person_likes_comment_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'STUDY_AT',
'/home/age-benchmark-dataset/sf-1/dynamic/person_studyAt_organisation_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'WORK_AT',
'/home/age-benchmark-dataset/sf-1/dynamic/person_workAt_organisation_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'HAS_CREATOR',
'/home/age-benchmark-dataset/sf-1/dynamic/post_hasCreator_person_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'HAS_TAG',
'/home/age-benchmark-dataset/sf-1/dynamic/post_hasTag_tag_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'IS_LOCATED_IN',
'/home/age-benchmark-dataset/sf-1/dynamic/post_isLocatedIn_place_0_0.csv', true);


SELECT load_labels_from_file('benchmark', 'Organisation',
'/home/age-benchmark-dataset/sf-1/static/organisation_0_0.csv', true, true);

SELECT load_labels_from_file('benchmark', 'Place',
'/home/age-benchmark-dataset/sf-1/static/place_0_0.csv', true, true);

SELECT load_labels_from_file('benchmark', 'Tag',
'/home/age-benchmark-dataset/sf-1/static/tag_0_0.csv', true, true);

SELECT load_labels_from_file('benchmark', 'Tagclass',
'/home/age-benchmark-dataset/sf-1/static/tagclass_0_0.csv', true, true);


SELECT load_edges_from_file('benchmark', 'IS_LOCATED_IN',
'/home/age-benchmark-dataset/sf-1/static/organisation_isLocatedIn_place_0_0.csv', true);

SELECT load_edges_from_file('benchmark', 'IS_PART_OF',
'/home/age-benchmark-dataset/sf-1/static/place_isPartOf_place_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'IS_SUBCLASS_OF',
'/home/age-benchmark-dataset/sf-1/static/tagclass_isSubclassOf_tagclass_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'HAS_TYPE',
'/home/age-benchmark-dataset/sf-1/static/tag_hasType_tagclass_0_0.csv', true);





=================================================================================================================================================



DROP EXTENSION age CASCADE; CREATE EXTENSION age; LOAD 'age'; SET search_path to ag_catalog; DROP SCHEMA benchmark CASCADE;
SELECT create_graph('benchmark');

SELECT create_vlabel('benchmark', 'Comment');
SELECT create_vlabel('benchmark', 'Person');
SELECT create_vlabel('benchmark', 'Forum');
SELECT create_vlabel('benchmark', 'Post');

SELECT create_elabel('benchmark', 'HAS_CREATOR');
SELECT create_elabel('benchmark', 'HAS_TAG');
SELECT create_elabel('benchmark', 'IS_LOCATED_IN');
SELECT create_elabel('benchmark', 'REPLY_OF');
SELECT create_elabel('benchmark', 'CONTAINER_OF');
SELECT create_elabel('benchmark', 'HAS_MEMBER');
SELECT create_elabel('benchmark', 'HAS_MODERATOR');
SELECT create_elabel('benchmark', 'HAS_TAG');
SELECT create_elabel('benchmark', 'HAS_INTEREST');
SELECT create_elabel('benchmark', 'KNOWS');
SELECT create_elabel('benchmark', 'LIKES');
SELECT create_elabel('benchmark', 'STUDY_AT');
SELECT create_elabel('benchmark', 'WORK_AT');

SELECT create_vlabel('benchmark', 'Organisation');
SELECT create_vlabel('benchmark', 'Place');
SELECT create_vlabel('benchmark', 'Tag');
SELECT create_vlabel('benchmark', 'Tagclass');

SELECT create_elabel('benchmark', 'IS_PART_OF');
SELECT create_elabel('benchmark', 'IS_SUBCLASS_OF');
SELECT create_elabel('benchmark', 'HAS_TYPE');

SELECT load_labels_from_file('benchmark', 'Comment',
'/home/zainab/benchmarking/sf-10/dynamic/comment_0_0.csv', true, true);

SELECT load_labels_from_file('benchmark', 'Person',
'/home/zainab/benchmarking/sf-10/dynamic/person_0_0.csv', true, true);

SELECT load_labels_from_file('benchmark', 'Forum',
'/home/zainab/benchmarking/sf-10/dynamic/forum_0_0.csv', true, true);

SELECT load_labels_from_file('benchmark', 'Post',
'/home/zainab/benchmarking/sf-10/dynamic/post_0_0.csv', true, true);


SELECT load_edges_from_file('benchmark', 'HAS_CREATOR',
'/home/zainab/benchmarking/sf-10/dynamic/comment_hasCreator_person_0_0.csv', true);

SELECT load_edges_from_file('benchmark', 'HAS_TAG',
'/home/zainab/benchmarking/sf-10/dynamic/comment_hasTag_tag_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'IS_LOCATED_IN',
'/home/zainab/benchmarking/sf-10/dynamic/comment_isLocatedIn_place_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'REPLY_OF',
'/home/zainab/benchmarking/sf-10/dynamic/comment_replyOf_comment_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'REPLY_OF',
'/home/zainab/benchmarking/sf-10/dynamic/comment_replyOf_post_0_0.csv', true);

SELECT load_edges_from_file('benchmark', 'CONTAINER_OF',
'/home/zainab/benchmarking/sf-10/dynamic/forum_containerOf_post_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'HAS_MEMBER',
'/home/zainab/benchmarking/sf-10/dynamic/forum_hasMember_person_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'HAS_MODERATOR',
'/home/zainab/benchmarking/sf-10/dynamic/forum_hasModerator_person_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'HAS_TAG',
'/home/zainab/benchmarking/sf-10/dynamic/forum_hasTag_tag_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'HAS_INTEREST',
'/home/zainab/benchmarking/sf-10/dynamic/person_hasInterest_tag_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'IS_LOCATED_IN',
'/home/zainab/benchmarking/sf-10/dynamic/person_isLocatedIn_place_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'KNOWS',
'/home/zainab/benchmarking/sf-10/dynamic/person_knows_person_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'LIKES',
'/home/zainab/benchmarking/sf-10/dynamic/person_likes_comment_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'STUDY_AT',
'/home/zainab/benchmarking/sf-10/dynamic/person_studyAt_organisation_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'WORK_AT',
'/home/zainab/benchmarking/sf-10/dynamic/person_workAt_organisation_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'HAS_CREATOR',
'/home/zainab/benchmarking/sf-10/dynamic/post_hasCreator_person_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'HAS_TAG',
'/home/zainab/benchmarking/sf-10/dynamic/post_hasTag_tag_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'IS_LOCATED_IN',
'/home/zainab/benchmarking/sf-10/dynamic/post_isLocatedIn_place_0_0.csv', true);


SELECT load_labels_from_file('benchmark', 'Organisation',
'/home/zainab/benchmarking/sf-10/static/organisation_0_0.csv', true, true);

SELECT load_labels_from_file('benchmark', 'Place',
'/home/zainab/benchmarking/sf-10/static/place_0_0.csv', true, true);

SELECT load_labels_from_file('benchmark', 'Tag',
'/home/zainab/benchmarking/sf-10/static/tag_0_0.csv', true, true);

SELECT load_labels_from_file('benchmark', 'Tagclass',
'/home/zainab/benchmarking/sf-10/static/tagclass_0_0.csv', true, true);


SELECT load_edges_from_file('benchmark', 'IS_LOCATED_IN',
'/home/zainab/benchmarking/sf-10/static/organisation_isLocatedIn_place_0_0.csv', true);

SELECT load_edges_from_file('benchmark', 'IS_PART_OF',
'/home/zainab/benchmarking/sf-10/static/place_isPartOf_place_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'IS_SUBCLASS_OF',
'/home/zainab/benchmarking/sf-10/static/tagclass_isSubclassOf_tagclass_0_0.csv', true);


SELECT load_edges_from_file('benchmark', 'HAS_TYPE',
'/home/zainab/benchmarking/sf-10/static/tag_hasType_tagclass_0_0.csv', true);

