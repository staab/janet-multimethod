(use assert)
(use multimethod)

(defmulti thing |($ :x))

(defmethod thing 1 [{:x x}] (inc x))
(defmethod thing 2 [{:x x}] (dec x))

(assert= 2 (thing {:x 1}))
(assert= 1 (thing {:x 2}))

(defmulti thing "stuff" |($ :x))

(defmethod thing 1 [{:x x}] (inc x))
(defmethod thing 2 [{:x x}] (dec x))

(assert= 2 (thing {:x 1}))
(assert= 1 (thing {:x 2}))
