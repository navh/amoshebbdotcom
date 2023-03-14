---
title: "Nexmark Paper"
date: 2023-03-14T10:23:43-04:00
tags: ["web-scale","streaming"]
---

Pete Tucker, Kristin Tufte, Vassilis Papadimos, David Maier.

### Bottom Line Up Front

I rate this 6.2.

README.md but formatted in beautiful unreadable dead-tree sized extra-hyphenated LaTeX and a few single-use acronyms (SUA)s to keep it confusing.

# Summary

## Intro

XMark measures XML format. Presenting Niagara Extension to XMark (NEXMark).

## Adapting to Streaming

EBay scenario. New people registering, new items submitted for auction, bids continuously arriving for items. Static files on disk for category information. 

Changes to XMark:
- Not XML specific.
- `bid`s are absolute, not relative increases.
- `auction` no has no closing price, a new `closed_auction` does.
- `closed_item` only contains closing date and buyerid.

## Queries

*stream-in*,*stream-out* queries. Continuous queries that take a stream as an input and output a stream. 

NOT addressed by this benchmark: triggers, ad-hoc queries. 

8 queries, Q5 to Q8 are window queries. 

### Q1: Currency Conversion

Test processing and parse speed of the stream system. Reference for the rest. 

### Q2: Selection

I would call this a filter. Outputs itemid and price where itemid is one of 5 specific numbers.

### Q3: Local Item Suggestion

Test join functionality. Joins a stream of new items to people, outputs when certain conditions met. Watch out for closed auctions. My guess is authors struggled with zombies on this one.

### Q4: Average Price for a Category

Join static category file to closed_auction stream, calculate average closing price for each. 

### Q5: Hot Items

Time-based, sliding window, group-by operation.
Every minute outputs the item with the most bids in the last hour. 

### Q6: Average Selling Price by Seller

Event-based, sliding window.
For each closing auction, output average selling price of last 10 auctions done by seller.

### Q7: Highest bid

Time-based, fixed window. 
Every 10 minutes, return highest bid and itemid in the most recent 10 minutes.

### Q8: Monitor New Users

Time-based, sliding window. 
People who opened an auction in last 12 hours.

## NEXMark Implementation

### Firehose Stream Generator 

Work in progress? Does what you think, knobs to turn for each stream.  

### Scale 

- Static File Size: Larger file make take longer to query against.
- Number of bid streams: More is more.
- Stream rate: For every 1 bid, 0.1 items, 0.01 persons. Dial up and down.
- Test duration: duration. 

## Metrics

Unbounded queries never terminate, time can't be used. 

- How fast is system? Input stream rate. Tuple Latency.
- How accurate is system? Output matching.

Create output of ideal system (zero latency, perfect accuracy) offline, measure and compare online latency and results.
