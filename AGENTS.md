# ClojureDart 학습 노트

## Dart 객체 속성 접근

### 기본 문법

```clojure
;; 속성 읽기
(.-prop obj)

;; 속성 쓰기
(.-prop! obj x)
(set! (.-prop obj) x)
```

### :flds를 이용한 구조 분해 (권장)

여러 속성을 한번에 추출할 때 사용:

```clojure
;; 이렇게 쓰는 대신
(let [height (.-height size)
      width (.-width size)]
  ...)

;; 이렇게 간결하게 쓸 수 있음
(let [{:flds [height width]} size]
  ...)
```

중첩된 객체도 구조 분해 가능:

```clojure
(let [{:flds [id title body tags views reactions]} post
      {:flds [likes dislikes]} reactions]
  ...)
```

### 정적 속성 접근

정적 속성은 dot 체이닝 형태로 접근:

```clojure
m/Colors.purple
m/Colors.purple.shade900
(m/Colors.purple.shade900.withAlpha 128)
```

### 메서드 호출

```clojure
;; Dart: client.get(url)
(.get client url)

;; Dart: response.toJson()
(.toJson response)

;; 정적 메서드/팩토리
(models/Post.fromJson data)
```

## 스키마/타입 검증

ClojureDart에서는 `clojure.spec.alpha`와 `malli`를 사용할 수 없음.

### 권장 방법: Dart DTO + json_serializable

1. `json_annotation`, `json_serializable`, `build_runner` 패키지 추가
2. Dart 클래스 정의 (`lib/models/post.dart`):

```dart
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
```

3. 코드 생성: `flutter pub run build_runner build`

4. ClojureDart에서 사용:

```clojure
(ns my.app
  (:require ["package:my_app/models/post.dart" :as models]))

;; JSON -> Dart 객체
(models/Post.fromJson data)

;; 속성 접근
(let [{:flds [id title body]} post]
  ...)
```

## API 호출 (dio)

```clojure
(ns my.api
  (:require ["package:dio/dio.dart" :as dio]
            ["package:my_app/models/post.dart" :as models]))

(def ^:private client (dio/Dio))

(defn get-all []
  (-> (.get client "https://api.example.com/posts")
      (.then (fn [^dio/Response response]
               (let [{:flds [data]} response]
                 (models/PostsResponse.fromJson data))))))
```

## 참고 문서

- [ClojureDart 공식 문서](https://github.com/Tensegritics/ClojureDart/blob/main/doc/README.md)
