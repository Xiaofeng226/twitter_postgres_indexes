SET max_parallel_maintenance_workers=80;
SET maintenance_work_mem='16GB';
CREATE INDEX idx_tweets_jsonb_lang ON tweets_jsonb ((data->>'lang'));
CREATE INDEX ON tweets_jsonb USING GIN((data->'entities'->'hashtags') jsonb_path_ops);
CREATE INDEX ON tweets_jsonb USING GIN((data->'extended_tweet'->'entities'->'hashtags') jsonb_path_ops);
CREATE INDEX ON tweets_jsonb USING GIN(to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')));
