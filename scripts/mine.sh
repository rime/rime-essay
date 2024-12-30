export LC_ALL=zh.UTF-8

# before PR #36
old_commit='e0519d0'
# PR #36 with revisions
new_commit='mine'

git checkout ${old_commit} -- essay.txt
sort -u essay.txt > essay.old

git checkout ${new_commit} -- essay.txt
sort -u essay.txt > essay.new

awk '$2 >= 10' essay.new > high.txt
awk '$2 < 10' essay.new > low.txt

sort low.txt essay.old | uniq --repeated > low-old.txt
sort low.txt low-old.txt | uniq --unique > low-new.txt
sort essay.old high.txt | awk '{
  if (k != $1) {
    if (k != "") print(k "\t" v);
    k = $1;
    v = $2;
  } else {
    if (v < $2) { v = $2; }
  }
}
END { print(k "\t" v); }' > essay.txt

echo ---
wc -l essay.{old,new,txt}
echo ---
wc -l high.txt low.txt
echo ---
wc -l low-{old,new}.txt
echo ...
