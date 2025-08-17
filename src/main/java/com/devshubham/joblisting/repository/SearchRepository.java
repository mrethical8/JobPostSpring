package com.devshubham.joblisting.repository;

import com.devshubham.joblisting.model.Post;

import java.util.List;

public interface SearchRepository {

    List<Post> findByText(String text);

}
