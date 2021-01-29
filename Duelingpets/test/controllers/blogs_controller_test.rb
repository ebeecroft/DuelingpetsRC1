require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blog = blogs(:one)
  end

  test "should get index" do
    get blogs_url
    assert_response :success
  end

  test "should get new" do
    get new_blog_url
    assert_response :success
  end

  test "should create blog" do
    assert_difference('Blog.count') do
      post blogs_url, params: { blog: { adbanner: @blog.adbanner, adbannerpurchased: @blog.adbannerpurchased, admascot: @blog.admascot, blogtype_id: @blog.blogtype_id, blogviewer_id: @blog.blogviewer_id, bookgroup_id: @blog.bookgroup_id, created_on: @blog.created_on, description: @blog.description, largeimage1: @blog.largeimage1, largeimage1purchased: @blog.largeimage1purchased, largeimage2: @blog.largeimage2, largeimage2purchased: @blog.largeimage2purchased, largeimage3: @blog.largeimage3, largeimage3purchased: @blog.largeimage3purchased, mp3: @blog.mp3, musicpurchased: @blog.musicpurchased, ogg: @blog.ogg, pointsreceived: @blog.pointsreceived, reviewed: @blog.reviewed, reviewed_on: @blog.reviewed_on, smallimage1: @blog.smallimage1, smallimage1purchased: @blog.smallimage1purchased, smallimage2: @blog.smallimage2, smallimage2purchased: @blog.smallimage2purchased, smallimage3: @blog.smallimage3, smallimage3purchased: @blog.smallimage3purchased, smallimage4: @blog.smallimage4, smallimage4purchased: @blog.smallimage4purchased, smallimage5: @blog.smallimage5, smallimage5purchased: @blog.smallimage5purchased, title: @blog.title, updated_on: @blog.updated_on, user_id: @blog.user_id } }
    end

    assert_redirected_to blog_url(Blog.last)
  end

  test "should show blog" do
    get blog_url(@blog)
    assert_response :success
  end

  test "should get edit" do
    get edit_blog_url(@blog)
    assert_response :success
  end

  test "should update blog" do
    patch blog_url(@blog), params: { blog: { adbanner: @blog.adbanner, adbannerpurchased: @blog.adbannerpurchased, admascot: @blog.admascot, blogtype_id: @blog.blogtype_id, blogviewer_id: @blog.blogviewer_id, bookgroup_id: @blog.bookgroup_id, created_on: @blog.created_on, description: @blog.description, largeimage1: @blog.largeimage1, largeimage1purchased: @blog.largeimage1purchased, largeimage2: @blog.largeimage2, largeimage2purchased: @blog.largeimage2purchased, largeimage3: @blog.largeimage3, largeimage3purchased: @blog.largeimage3purchased, mp3: @blog.mp3, musicpurchased: @blog.musicpurchased, ogg: @blog.ogg, pointsreceived: @blog.pointsreceived, reviewed: @blog.reviewed, reviewed_on: @blog.reviewed_on, smallimage1: @blog.smallimage1, smallimage1purchased: @blog.smallimage1purchased, smallimage2: @blog.smallimage2, smallimage2purchased: @blog.smallimage2purchased, smallimage3: @blog.smallimage3, smallimage3purchased: @blog.smallimage3purchased, smallimage4: @blog.smallimage4, smallimage4purchased: @blog.smallimage4purchased, smallimage5: @blog.smallimage5, smallimage5purchased: @blog.smallimage5purchased, title: @blog.title, updated_on: @blog.updated_on, user_id: @blog.user_id } }
    assert_redirected_to blog_url(@blog)
  end

  test "should destroy blog" do
    assert_difference('Blog.count', -1) do
      delete blog_url(@blog)
    end

    assert_redirected_to blogs_url
  end
end
