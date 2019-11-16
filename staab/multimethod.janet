# Get-meta is a sentinel value that allows us to return meta
(def- $get-meta (gensym))

(defn multimethod
  [dispatch]
  (let [methods @{}
        meta {:dispatch dispatch :methods methods}]
    (fn [& args]
      (if
        (= $get-meta (first args))
        meta
        (let [method (or (methods (dispatch ;args)) (methods :default))]
          (if method
            (method ;args)
            (error (string/format "No method found for dispatch values: %q" args))))))))

(defmacro defmulti
  [name & opts]
  (let [[docstring dispatch] (if (string? (first opts)) opts [(string name) ;opts])]
    ~(def ,name ,docstring (multimethod ,dispatch))))

(defn add-method
  [mm k f]
  (put ((mm $get-meta) :methods) k f))

(defmacro defmethod
  [mm k & body]
  ~(add-method ,mm ,k (fn ,;body)))
