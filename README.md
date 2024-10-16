# README


## First steps (branch setp2)
- Step 1: Generate Graphql Files
- Step 2: Query test fields

```text
    # mutation
    mutation { testField }
```

```text
    mutation { testField }
```
## Step 3 (branch step3)

- Create Post Scaffold
- Create Comments Scaffold
- Setup Factory
- Create Mutation and Test
  - make field
  - create mutation class
  - create attributes
  - create return type (use and show generator)
  - create resolver and test
  - Try to explain fragments while writing query
  - Ask everyone to create mutation for comment
  - implement together fetching comments from post

```graphql
        mutation {
         createPost(
          input: { attributes: { title: "#{params[:title]}", description: "#{params[:description]}" }}
         ) {
          title description
        }
      }
```

```graphql
mutation createPost($input: CreatePostInput!) {
        createPost(input: $input) {
          title description
        }
      }
```

## Step 4 (branch step3)
- implement posts query
